//
//  MBData.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 21/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

/*
 MBData is designed to be used with MBCollectionViewFirstXibCell
 */

@interface MBData : NSObject
/*
 strings represent labels' text on the cell
 */
@property (nonatomic, copy) NSString *topText;
@property (nonatomic, copy) NSString *bottomText;

/*
 image represents image of imageView on the cell
 */
@property (nonatomic, copy) UIImage *image;

@end
