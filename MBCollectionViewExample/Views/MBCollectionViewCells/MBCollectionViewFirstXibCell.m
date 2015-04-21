//
//  MBCollectionViewFirstXibCell.m
//  MBCollectionViewExample
//
//  Created by Mert Buran on 21/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBCollectionViewFirstXibCell.h"
#import "UIView+MBView.h"
#import <MapKit/MKMapView.h>

@interface MBCollectionViewFirstXibCell ()
@property (nonatomic) MBCellMode cellMode;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@end

@implementation MBCollectionViewFirstXibCell

+ (instancetype)initWithNibOfCell {
    MBCollectionViewFirstXibCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MBCollectionViewFirstXibCell class]) owner:nil options:nil] objectAtIndex:0];
    cell.cellMode = MBCellModeImageView;
    return cell;
}

- (void)setCellMode:(MBCellMode)cellMode {
    if (_cellMode != cellMode) {
        _cellMode = cellMode;
        switch (cellMode) {
            case MBCellModeImageView: {
                [self.mapView setHidden:YES];
                [self.imageView setHidden:NO];
                break;
            }
            case MBCellModeMapView: {
                [self.mapView setHidden:NO];
                [self.imageView setHidden:YES];
                break;
            }
            default:
                break;
        }
        [self updateConstraints];
        [self layoutIfNeeded];
    }
}

- (void)setText:(NSString *)text forLabelPosition:(MBCellLabelPosition)labelPosition {
    switch (labelPosition) {
        case MBCellLabelPositionTop: {
            self.topLabel.text = text;
            break;
        }
        case MBCellLabelPositionBottom: {
            self.bottomLabel.text = text;
            break;
        }
        default: {
            break;
        }
    }
}

- (void)autoAdjustPreferredMaxLayoutWidthForSubviewLabels {
    self.topLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.topLabel.bounds);
    self.bottomLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bottomLabel.bounds);
}

- (void)setImage:(UIImage *)image {
    if (self.cellMode == MBCellModeImageView && ![self.imageView.image isEqual:image]) {
        self.imageView.image = image;
    }
}

- (void)sizeToFit {
    [super sizeToFit];
    [self autoAdjustPreferredMaxLayoutWidthForSubviewLabels];
    [self setSize:[self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize]];
}

@end
