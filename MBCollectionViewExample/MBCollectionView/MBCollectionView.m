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

static const CGFloat kMBCollectionViewHeightThreshold = 20.f;

@interface MBCollectionView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *itemViewPool;
@property (nonatomic, strong) NSMutableArray *visibleItemViews;
@property (nonatomic, strong) NSMutableArray *itemHeightsArray; //very critical for prepareForReuse phase
@property (nonatomic) BOOL heightCalculationFinished;
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
    self.heightCalculationFinished = NO;
    self.visibleItemViews = [NSMutableArray array];
    self.itemHeightsArray = [NSMutableArray array];
    self.itemViewPool = [NSMutableArray array];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.scrollView setDelegate:self];
    [self.scrollView setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:self.scrollView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initialSetup];
}

- (void)initialSetup {
    [self resetScrollView];
    [self.scrollView setFrame:self.bounds];
    [self drawInitialCells];
}

- (void)resetScrollView {
    [self.visibleItemViews removeAllObjects];
    [self.scrollView removeAllSubviewsOfClass:[MBCollectionViewCell class]];
}

- (void)drawInitialCells {
    MBRow row = 0;
    CGFloat posY = 0.f;
    do {
        MBCollectionViewCell *cell = [self addVisibleCellToRow:row];
        CGFloat cellHeight = CGRectGetHeight(cell.bounds);
        posY += cellHeight;
        row++;
    } while (posY <= CGRectGetHeight(self.scrollView.bounds) + kMBCollectionViewHeightThreshold);
    
    CGFloat estimatedContentHeight = (posY / row) * [self.dataSource rowCount];
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds), estimatedContentHeight);
    [self.scrollView setContentSize:contentSize];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //TODO: the most critical point for reusing item views
    if ([MBCollectionView isBounds:scrollView.bounds withinContentSize:scrollView.contentSize]) {
        CGFloat minVisibleY = CGRectGetMinY(scrollView.bounds);
        CGFloat maxVisibleY = CGRectGetMaxY(scrollView.bounds);
        
#warning check the conditions until it is ok, not just once
        MBCollectionViewCell *topVisibleCell = [self.visibleItemViews firstObject];
        if ([topVisibleCell getMaxY] < minVisibleY - kMBCollectionViewHeightThreshold) {
            [self removeInvisibleCell:topVisibleCell];
        }
        else if ([topVisibleCell getMinY] > minVisibleY + kMBCollectionViewHeightThreshold){
            [self addVisibleCellToRow:topVisibleCell.rowIndex-1];
        }
        
        MBCollectionViewCell *bottomVisibleCell = [self.visibleItemViews lastObject];
        if ([bottomVisibleCell getMinY] > maxVisibleY + kMBCollectionViewHeightThreshold) {
            [self removeInvisibleCell:bottomVisibleCell];
        }
        else if ([bottomVisibleCell getMaxY] < maxVisibleY - kMBCollectionViewHeightThreshold) {
            [self addVisibleCellToRow:bottomVisibleCell.rowIndex+1];
        }
    }
}

#pragma mark - Add/Remove Cell methods

- (MBCollectionViewCell *)getViewForRow:(MBRow)row; {
    //!!!TODO: put itemView into a container view!!!
    MBCollectionViewCell *itemView = [self.dataSource viewForRow:row];
    [itemView setRowIndex:row];
    return itemView;
}

#warning TODO: IMPLEMENT REUSABILITY!!!
- (MBCollectionView *)dequeueReusableCell {
    return nil;
}

- (MBCollectionViewCell *)addVisibleCellToRow:(MBRow)row {
    MBCollectionViewCell *visibleCell = [self getViewForRow:row];
    CGFloat cellHeight = CGRectGetHeight(visibleCell.bounds);
    if (self.itemHeightsArray.count <= row || [[self.itemHeightsArray objectAtIndex:row] floatValue] != cellHeight) {
        [self.itemHeightsArray insertObject:@(cellHeight) atIndex:row];
        
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
    return visibleCell;
}

- (void)correctContentSizeWithActualHeight:(CGFloat)actualHeight forRow:(MBRow)row {
    CGFloat averageCellHeight = self.scrollView.contentSize.height / [self.dataSource rowCount];
    CGFloat difference = actualHeight - averageCellHeight;
    CGSize contentSize = self.scrollView.contentSize;
    [self.scrollView setContentSize:CGSizeMake(contentSize.width, contentSize.height + difference)];
}

- (void)removeInvisibleCell:(MBCollectionViewCell *)invisibleCell {
    [self.itemViewPool addObject:invisibleCell];
    [self.visibleItemViews removeObject:invisibleCell];
    [invisibleCell removeFromSuperview];
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

@end
