//
//  MBCollectionViewCell.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 16/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBCollectionViewCell : UIView
@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic) NSUInteger rowIndex;
- (void)prepareForReuse;
+ (UIColor *)customBackgroundColor;
@end
