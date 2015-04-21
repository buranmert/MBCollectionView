//
//  MBCollectionViewDataSource.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 19/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBCollectionView;
@class MBCollectionViewCell;

typedef NSUInteger MBRow;

/*
 Data Source protocol is as simple as it can be.
 All it should tell is how many items to draw on MBCollectionView and what view corresponds to given row.
 
 !!!IMPORTANT!!!
 viewForRow method is responsible for the size of view it returns. MBCollectionView does not restrict you having your cells as wide as MBCollectionView itself.
 MBCollectionView only guarantess cells start from X = 0 point and they are layed out vertically.
 Data source implementation should resize the view arbitrarily if it is needed.
 */

@protocol MBCollectionViewDataSource <NSObject>

- (MBRow)rowCount;
- (MBCollectionViewCell *)collectionView:(MBCollectionView *)collectionView viewForRow:(MBRow)row;

@end
