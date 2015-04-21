//
//  UIView+MBView.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 15/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MBView)
/*
 add subview with given inset values. if an inset value is below 0, then that side of subview is not pinned to superview/self
 */
-(NSArray *)addSubview:(UIView *)childView withInset:(UIEdgeInsets)edgeInsets;
- (CGFloat)getMinY;
- (CGFloat)getMaxY;
- (void)setOriginY:(CGFloat)originY;
- (void)setOriginX:(CGFloat)originX;
- (void)setHeight:(CGFloat)height;
- (void)setSize:(CGSize)size;
/*
 removes all subviews which are instances of given aClass
 */
- (void)removeAllSubviewsOfClass:(Class)aClass;
@end
