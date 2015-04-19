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
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        [label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:label];
        _textLabel = label;
        [self setBackgroundColor:[[self class] customBackgroundColor]];
    }
    return self;
}

- (void)prepareForReuse {
    //reserved for future use
}

+ (UIColor *)customBackgroundColor {
    return [UIColor redColor];
}

@end
