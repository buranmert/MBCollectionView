//
//  MBCollectionView.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 15/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBCollectionViewCell;

typedef NSUInteger MBRow;

@protocol MBCollectionViewDataSource <NSObject>

- (MBRow)rowCount;
- (MBCollectionViewCell *)viewForRow:(MBRow)row;

@end

@interface MBCollectionView : UIView
@property (nonatomic, weak) IBOutlet id<MBCollectionViewDataSource> dataSource;
- (MBCollectionView *)dequeueReusableCell;
@end
