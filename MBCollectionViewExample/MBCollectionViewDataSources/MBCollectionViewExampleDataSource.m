//
//  MBCollectionViewExampleDataSource.m
//  MBCollectionViewExample
//
//  Created by Mert Buran on 16/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBCollectionViewExampleDataSource.h"
#import "MBCollectionViewCell.h"

@implementation MBCollectionViewExampleDataSource

- (MBRow)rowCount {
    return 10;
}

- (CGFloat)estimatedItemHeightForRow:(MBRow)row {
    return 70.f;
}

- (MBCollectionViewCell *)viewForRow:(MBRow)row {
    MBCollectionViewCell *cell = [[MBCollectionViewCell alloc] initWithFrame:CGRectMake(0.f, 0.f, 50.f, 60.f)];
    [cell setBackgroundColor:(row%2==0?[UIColor redColor]:[UIColor greenColor])];
    return cell;
}

@end
