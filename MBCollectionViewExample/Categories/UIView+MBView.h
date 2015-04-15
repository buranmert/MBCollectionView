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
@end
