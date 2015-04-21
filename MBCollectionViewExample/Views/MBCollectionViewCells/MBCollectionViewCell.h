//
//  MBCollectionViewCell.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 16/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 base cell class for MBCollectionView
 */
@interface MBCollectionViewCell : UIView
#warning MUST BE READONLY! MUST BE FIXED!
/*
 cell provide index information (but it must be read-only to avoid wrong index values)
 */
@property (nonatomic) NSUInteger rowIndex;

/*
 prepareForReuse method is called just after a cell is dequeued from cell pool in MBCollectionView
 */
- (void)prepareForReuse;

@end
