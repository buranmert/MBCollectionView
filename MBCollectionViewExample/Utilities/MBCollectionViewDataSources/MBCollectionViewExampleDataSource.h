//
//  MBCollectionViewExampleDataSource.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 16/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBCollectionViewDataSource.h"

@class MBData;

@interface MBCollectionViewExampleDataSource : NSObject <MBCollectionViewDataSource>
/*
 MBCollectionViewDelegate does not have to store data to use it, it can call getDataForRow from this data source to have data
 */
- (MBData *)getDataForRow:(MBRow)row;
@end
