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
    //reserved for future use
}

- (void)prepareForReuse {
    //reserved for future use
}

- (void)setRowIndex:(MBRow)newRowIndex {
    if (_rowIndex != newRowIndex) {
        _rowIndex = newRowIndex;
    }
}

@end
