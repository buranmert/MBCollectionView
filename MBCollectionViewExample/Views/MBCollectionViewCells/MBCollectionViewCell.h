//
//  MBCollectionViewCell.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 16/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSUInteger MBRow;

/*
 base cell class for MBCollectionView
 */
@interface MBCollectionViewCell : UIView
@property (nonatomic, readonly) MBRow rowIndex;
/*
 prepareForReuse method is called just after a cell is dequeued from cell pool in MBCollectionView
 */
- (void)prepareForReuse;
@end
