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

@interface MBCollectionView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary *itemViewPool;
@property (nonatomic, strong) NSMutableArray *visibleItemViews;
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
    self.itemViewPool = [NSMutableDictionary dictionary];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.scrollView setDelegate:self];
    [self.scrollView setBackgroundColor:[UIColor greenColor]];
    
    UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(30.f, 40.f, 50.f, 60.f)];
    [dummyView setBackgroundColor:[UIColor redColor]];
    [self.scrollView addSubview:dummyView];
    
    [self addSubview:self.scrollView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.scrollView setFrame:self.bounds];
    CGSize contentSize = [self getContentSize];
    [self.scrollView setContentSize:contentSize];
}

- (void)setDataSource:(id<MBCollectionViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self.scrollView setContentSize:[self getContentSize]];
}

- (CGSize)getContentSize {
    //call dataSource estimatedItemSize method for all items and calculate total
    NSUInteger maxRow = [self.dataSource rowCount];
    CGFloat estimatedTotalHeight = 0.f;
    for (MBRow row = 0; row < maxRow; row++) {
        estimatedTotalHeight += [self.dataSource estimatedItemHeightForRow:row];
    }
    return CGSizeMake(CGRectGetWidth(self.bounds), estimatedTotalHeight);
}

- (MBCollectionViewCell *)getViewForRow:(MBRow)row; {
    //!!!TODO: put itemView into a container view!!!
    MBCollectionViewCell *itemView = [self.dataSource viewForRow:row];
    return itemView;
}

- (void)correctContentSizeWithActualHeight:(CGFloat)actualHeight forRow:(MBRow)row {
    if (self.heightCalculationFinished == NO) {
        CGFloat difference = actualHeight - [self.dataSource estimatedItemHeightForRow:row];
        CGSize contentSize = self.scrollView.contentSize;
        [self.scrollView setContentSize:CGSizeMake(contentSize.width, contentSize.height + difference)];
        if (row + 1 >= [self.dataSource rowCount]) {
            self.heightCalculationFinished = YES;
        }
    }
}

- (void)addItemViewToTop {
    
}

- (void)addItemViewToBottom {
    
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //TODO: the most critical point for reusing item views
}

@end
