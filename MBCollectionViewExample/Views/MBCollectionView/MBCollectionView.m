//
//  MBCollectionView.m
//  MBCollectionViewExample
//
//  Created by Mert Buran on 15/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBCollectionView.h"
#import "MBCollectionViewCell.h"
#import "UIView+MBView.h"

static const CGFloat kMBCollectionViewHeightThreshold = 20.f; //collectionView draws new cells if there is no drawn cell within (bounds + threshold) to improve UX

@interface MBCollectionView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary *itemViewPool;
@property (nonatomic, strong) NSMutableArray *visibleItemViews;
@property (nonatomic, strong) NSMutableArray *itemHeightsArray; //very critical for prepareForReuse phase
@property (nonatomic) BOOL isHeightCorrectionFinished;
@end

@implementation MBCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [self commonInit];
}

- (void)commonInit {
    self.isHeightCorrectionFinished = NO;
    self.visibleItemViews = [NSMutableArray array];
    self.itemHeightsArray = [NSMutableArray array];
    self.itemViewPool = [NSMutableDictionary dictionary];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.scrollView setDelegate:self];
    [self.scrollView setBackgroundColor:[UIColor yellowColor]];
    [self.scrollView setShowsVerticalScrollIndicator:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:YES];
    [self.scrollView setDirectionalLockEnabled:YES];
    [self addSubview:self.scrollView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
    [self.scrollView addGestureRecognizer:recognizer];
}

- (void)scrollViewTapped:(UITapGestureRecognizer *)recognizer {
    CGPoint tappedPoint = [recognizer locationInView:recognizer.view];
    UIView *tappedView = [recognizer.view hitTest:tappedPoint withEvent:nil];
    MBCollectionViewCell *tappedCell = nil;
    while ([tappedView superview] != nil) {
        if ([tappedView isKindOfClass:[MBCollectionViewCell class]]) {
            tappedCell = (MBCollectionViewCell *)tappedView;
            break;
        }
        else {
            tappedView = [tappedView superview];
        }
    }
    if (tappedCell != nil && [self.delegate respondsToSelector:@selector(collectionView:didTapOnCell:)]) {
        [self.delegate collectionView:self didTapOnCell:tappedCell];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initialSetup];
}

- (void)initialSetup {
    [self resetScrollView];
    [self.scrollView setFrame:self.bounds];
    [self drawInitialCellsWithCompletionHandler:nil];
}

- (void)resetScrollView {
    self.isHeightCorrectionFinished = NO;
    [self.visibleItemViews removeAllObjects];
    [self.itemHeightsArray removeAllObjects];
    [self.itemViewPool removeAllObjects];
    [self.scrollView removeAllSubviewsOfClass:[MBCollectionViewCell class]];
    CGPoint initialPoint = CGPointMake(-self.scrollView.contentInset.left, -self.scrollView.contentInset.top);
    [self.scrollView setContentOffset:initialPoint animated:NO];
}

- (void)reloadCollectionViewWithCompletionHandler:(void (^)())completion {
    [self resetScrollView];
    [self drawInitialCellsWithCompletionHandler:completion];
}

- (void)drawInitialCellsWithCompletionHandler:(void (^)())completion {
    MBRow row = 0;
    MBRow totalRowCount = [self.dataSource rowCount];
    CGFloat posY = 0.f;
    CGFloat maxWidth = CGRectGetWidth(self.scrollView.bounds);
    while (posY <= CGRectGetHeight(self.scrollView.bounds) + kMBCollectionViewHeightThreshold && row < totalRowCount) {
        MBCollectionViewCell *cell = [self addVisibleCellToRow:row withContentSizeCorrection:NO];
        CGFloat cellWidth = CGRectGetWidth(cell.bounds);
        maxWidth = MAX(maxWidth, cellWidth);
        CGFloat cellHeight = CGRectGetHeight(cell.bounds);
        posY += cellHeight;
        row++;
    }
    CGFloat estimatedAverageCellHeight = (posY / row);
    CGFloat estimatedContentHeight = estimatedAverageCellHeight * totalRowCount;
    CGSize contentSize = CGSizeMake(maxWidth, estimatedContentHeight);
    [self.scrollView setContentSize:contentSize];
    for (MBRow i = row + 1; i <= totalRowCount; i++) {
        [self.itemHeightsArray addObject:@(estimatedAverageCellHeight)];
    }
    if (completion != nil) {
        completion();
    }
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([MBCollectionView isBounds:scrollView.bounds withinContentSize:scrollView.contentSize]) {
        CGFloat topBorder = 0.f;
        CGFloat bottomBorder = scrollView.contentSize.height;
        CGFloat minVisibleY = CGRectGetMinY(scrollView.bounds);
        CGFloat maxVisibleY = CGRectGetMaxY(scrollView.bounds);
        
        BOOL needsToRemoveCellFromTop = YES;
        BOOL needsToAddCellToTop = YES;
        MBCollectionViewCell *topVisibleCell;
        while ((needsToRemoveCellFromTop || needsToAddCellToTop) && self.visibleItemViews.count > 0) {
            topVisibleCell = [self.visibleItemViews firstObject];
            needsToRemoveCellFromTop = ([topVisibleCell getMaxY] < minVisibleY - kMBCollectionViewHeightThreshold);
            needsToAddCellToTop = ([topVisibleCell getMinY] > MAX(topBorder, minVisibleY - kMBCollectionViewHeightThreshold));
            if (needsToRemoveCellFromTop) {
                [self removeInvisibleCell:topVisibleCell];
            }
            else if (needsToAddCellToTop){
                if ([self addVisibleCellToRow:topVisibleCell.rowIndex-1 withContentSizeCorrection:NO] == nil) {
                    break;
                }
            }
        }
        
        BOOL needsToRemoveCellFromBottom = YES;
        BOOL needsToAddCellToBottom = YES;
        MBCollectionViewCell *bottomVisibleCell;
        while ((needsToRemoveCellFromBottom || needsToAddCellToBottom) && self.visibleItemViews.count > 0) {
            bottomVisibleCell = [self.visibleItemViews lastObject];
            needsToRemoveCellFromBottom = [bottomVisibleCell getMinY] >  maxVisibleY + kMBCollectionViewHeightThreshold;
            needsToAddCellToBottom = [bottomVisibleCell getMaxY] < MIN(bottomBorder, maxVisibleY + kMBCollectionViewHeightThreshold);
            if (needsToRemoveCellFromBottom) {
                [self removeInvisibleCell:bottomVisibleCell];
            }
            else if (needsToAddCellToBottom){
                if ([self addVisibleCellToRow:bottomVisibleCell.rowIndex+1 withContentSizeCorrection:YES] == nil) {
                    break;
                }
            }
        }
    }
}

#pragma mark - Add/Remove Cell methods

- (MBCollectionViewCell *)getViewForRow:(MBRow)row {
    //!!!TODO: put itemView into a container view!!!
    MBCollectionViewCell *itemView = [self.dataSource collectionView:self viewForRow:row];
    [itemView setRowIndex:row];
    [itemView setOriginX:0.f];
    return itemView;
}

- (MBCollectionViewCell *)dequeueReusableCellForRow:(MBRow)row forClass:(Class)aClass {
    MBCollectionViewCell *reusableCell = [self getReusableCellFromPoolForClass:aClass];
    if (row < self.itemHeightsArray.count) {
        [reusableCell setHeight:[[self.itemHeightsArray objectAtIndex:row] floatValue]];
    }
    [reusableCell prepareForReuse];
    return reusableCell;
}

- (MBCollectionViewCell *)addVisibleCellToRow:(MBRow)row withContentSizeCorrection:(BOOL)correctionNeeded {
    if (row < [self.dataSource rowCount]) {
        MBCollectionViewCell *visibleCell = [self getViewForRow:row];
        CGSize cellSize = visibleCell.bounds.size;
        if (self.isHeightCorrectionFinished == NO) {
            if (correctionNeeded) {
                [self correctContentSizeWithActualSize:cellSize forRow:row];
            }
            [self setActualHeight:cellSize.height forRow:row];
            if (row + 1 >= [self.dataSource rowCount]) {
                self.isHeightCorrectionFinished = YES;
            }
        }
        CGFloat originY = 0.f;
        for (NSInteger i = 0; i < row; i++) {
            originY += [[self.itemHeightsArray objectAtIndex:i] floatValue];
        }
        [visibleCell setOriginY:originY];
        [self.visibleItemViews addObject:visibleCell];
        [self.visibleItemViews sortUsingComparator:^NSComparisonResult(MBCollectionViewCell *obj1, MBCollectionViewCell *obj2) {
            return obj1.rowIndex > obj2.rowIndex;
        }];
        [self.scrollView addSubview:visibleCell];
        
        //workaround for strange scrollIndicator shadowing issue
        [self.scrollView sendSubviewToBack:visibleCell];
        ///
        return visibleCell;
    }
    else {
        return nil;
    }
}

- (void)correctContentSizeWithActualSize:(CGSize)actualSize forRow:(MBRow)row {
    CGFloat widthDifference = MAX(0.f, actualSize.width - self.scrollView.contentSize.width);
    CGFloat expectedHeight = [[self.itemHeightsArray objectAtIndex:row] floatValue];
    CGFloat difference = actualSize.height - expectedHeight;
    if (difference != 0.f || widthDifference > 0.f) {
        CGSize contentSize = self.scrollView.contentSize;
        [self.scrollView setContentSize:CGSizeMake(contentSize.width + widthDifference, contentSize.height + difference)];
    }
}

- (void)removeInvisibleCell:(MBCollectionViewCell *)invisibleCell {
    [self addInvisibleCellToPool:invisibleCell];
    [self.visibleItemViews removeObject:invisibleCell];
    [invisibleCell removeFromSuperview];
}

- (void)addInvisibleCellToPool:(MBCollectionViewCell *)invisibleCell {
    NSString *reuseTag = NSStringFromClass([invisibleCell class]);
    NSMutableArray *arrayForReuseTag = [self.itemViewPool objectForKey:reuseTag];
    if (arrayForReuseTag == nil) {
        arrayForReuseTag = [NSMutableArray arrayWithObject:invisibleCell];
        [self.itemViewPool setObject:arrayForReuseTag forKey:reuseTag];
    }
    else {
        [arrayForReuseTag addObject:invisibleCell];
    }
}

- (MBCollectionViewCell *)getReusableCellFromPoolForClass:(Class)aClass {
    NSString *reuseTag = NSStringFromClass(aClass);
    NSMutableArray *arrayForReuseTag = [self.itemViewPool objectForKey:reuseTag];
    MBCollectionViewCell *reusableCell;
    if (arrayForReuseTag != nil && arrayForReuseTag.count > 0) {
        reusableCell = [arrayForReuseTag firstObject];
        [arrayForReuseTag removeObject:reusableCell];
    }
    return reusableCell;
}

#pragma mark - Helper methods

+ (BOOL)isBounds:(CGRect)bounds withinContentSize:(CGSize)contentSize {
    if (CGRectGetMinY(bounds) >= 0.f && CGRectGetMaxY(bounds) <= contentSize.height &&
        CGRectGetMinX(bounds) >= 0.f && CGRectGetMaxX(bounds) <= contentSize.width) {
        return YES;
    }
    else {
        return NO;
    }
}

- (CGFloat)setActualHeight:(CGFloat)height forRow:(MBRow)row {
    if (row >= self.itemHeightsArray.count) {
        [self.itemHeightsArray addObject:@(height)];
        return 0.f;
    }
    else {
        CGFloat oldValue = [[self.itemHeightsArray objectAtIndex:row] floatValue];
        [self.itemHeightsArray replaceObjectAtIndex:row withObject:@(height)];
        return oldValue;
    }
}

@end
