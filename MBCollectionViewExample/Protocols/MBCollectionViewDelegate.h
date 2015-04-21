//
//  MBCollectionViewDelegate.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 19/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBCollectionView;
@class MBCollectionViewCell;

@protocol MBCollectionViewDelegate <NSObject>
@optional
- (void)collectionView:(MBCollectionView *)collectionView didTapOnCell:(MBCollectionViewCell *)cell;
@end
