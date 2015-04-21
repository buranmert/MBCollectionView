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
- (MBData *)getDataForRow:(MBRow)row;
@end