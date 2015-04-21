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
/*
 MBCollectionView returns the cell itself as a cell is tapped.
 Since MBCollectionViewCell base class provides rowIndex information, delegate can access to the corresponding data model via collectionView if its data source provides a method like [collectionView.dataSource getDataForRow:cell.rowIndex]
 */
- (void)collectionView:(MBCollectionView *)collectionView didTapOnCell:(MBCollectionViewCell *)cell;
@end
