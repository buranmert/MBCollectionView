//
//  MBCollectionViewCell.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 16/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBCollectionViewCell : UIView
@property (nonatomic, strong) NSString *reuseTag;

#warning MUST BE A READONLY PROPERTY!!! MUST BE FIXED!!!
@property (nonatomic) NSUInteger rowIndex;
@end
