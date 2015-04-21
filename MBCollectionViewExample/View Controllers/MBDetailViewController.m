//
//  MBDetailViewController.m
//  MBCollectionViewExample
//
//  Created by Mert Buran on 21/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBDetailViewController.h"
#import "MBData.h"

@interface MBDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) MBData *data;
@end

@implementation MBDetailViewController

- (void)updateViewWithData:(MBData *)data {
    self.topLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.view.bounds)/2.f - CGRectGetMinX(self.topLabel.frame);
    self.bottomLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.view.bounds)/2.f - CGRectGetMaxX(self.bottomLabel.frame);
    
    self.topLabel.text = data.topText;
    self.bottomLabel.text = data.bottomText;
    if (data.image != nil && ![data.image isEqual:self.imageView.image]) {
        self.imageView.image = data.image;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViewWithData:self.data];
}

- (void)setDetailData:(MBData *)data {
    if (![_data isEqual:data]) {
        _data = data;
    }
}

@end
