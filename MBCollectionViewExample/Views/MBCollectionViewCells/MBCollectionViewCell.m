//
//  MBCollectionViewCell.m
//  MBCollectionViewExample
//
//  Created by Mert Buran on 16/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBCollectionViewCell.h"

@implementation MBCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [self commonInit];
}

- (void)commonInit {
    [self setBackgroundColor:[[self class] customBackgroundColor]];
}

- (void)prepareForReuse {
    //reserved for future use
}

+ (UIColor *)customBackgroundColor {
    return [UIColor redColor];
}

@end
