//
//  MBCollectionViewFirstXibCell.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 21/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBCollectionViewCell.h"

typedef NS_ENUM(NSUInteger, MBCellMode) {
    MBCellModeMapView,
    MBCellModeImageView,
};

typedef NS_ENUM(NSUInteger, MBCellLabelPosition) {
    MBCellLabelPositionTop,
    MBCellLabelPositionBottom,
};

@interface MBCollectionViewFirstXibCell : MBCollectionViewCell
+ (instancetype)initWithNibOfCell;
- (void)setCellMode:(MBCellMode)cellMode;
- (void)setText:(NSString *)text forLabelPosition:(MBCellLabelPosition)labelPosition;
- (void)autoAdjustPreferredMaxLayoutWidthForSubviewLabels;
- (void)setImage:(UIImage *)image;
@end
