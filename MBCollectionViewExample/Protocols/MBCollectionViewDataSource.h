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

@protocol MBCollectionViewDataSource <NSObject>

- (MBRow)rowCount;
- (MBCollectionViewCell *)collectionView:(MBCollectionView *)collectionView viewForRow:(MBRow)row;

@end
