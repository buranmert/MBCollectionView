//
//  UIView+MBView.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 15/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MBView)
-(NSArray *)addSubview:(UIView *)childView withInset:(UIEdgeInsets)edgeInsets;
- (CGFloat)getMinY;
- (CGFloat)getMaxY;
- (void)setOriginY:(CGFloat)originY;
- (void)setOriginX:(CGFloat)originX;
- (void)setHeight:(CGFloat)height;
- (void)setSize:(CGSize)size;
- (void)removeAllSubviewsOfClass:(Class)aClass;
@end
