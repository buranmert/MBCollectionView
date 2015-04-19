//
//  MBCollectionViewExampleDataSource.m
//  MBCollectionViewExample
//
//  Created by Mert Buran on 16/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBCollectionViewExampleDataSource.h"
#import "MBCollectionView.h"
#import "MBSecondCollectionViewCell.h"

#import "UIView+MBView.h"

@implementation MBCollectionViewExampleDataSource

- (MBRow)rowCount {
    return 40;
}

- (MBCollectionViewCell *)collectionView:(MBCollectionView *)collectionView viewForRow:(MBRow)row {
    MBCollectionViewCell *cell;
    if (row < 10) {
        cell = [collectionView dequeueReusableCellForRow:row forClass:[MBCollectionViewCell class]];
        if (cell == nil) {
            cell = [[MBCollectionViewCell alloc] initWithFrame:CGRectMake(0.f, 0.f, 50.f, 20.f)];
        }
        [cell setFrame:CGRectMake(0.f, 0.f, 50.f, 20.f)];
    }
    else if (row < 20) {
        cell = [collectionView dequeueReusableCellForRow:row forClass:[MBSecondCollectionViewCell class]];
        if (cell == nil) {
            cell = [[MBSecondCollectionViewCell alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 80.f)];
        }
        [cell setFrame:CGRectMake(0.f, 0.f, 100.f, 80.f)];
    }
    else if (row < 30) {
        cell = [collectionView dequeueReusableCellForRow:row forClass:[MBCollectionViewCell class]];
        if (cell == nil) {
            cell = [[MBCollectionViewCell alloc] initWithFrame:CGRectMake(0.f, 0.f, 150.f, 60.f)];
        }
        [cell setFrame:CGRectMake(0.f, 0.f, 150.f, 60.f)];
    }
    else {
        cell = [collectionView dequeueReusableCellForRow:row forClass:[MBSecondCollectionViewCell class]];
        if (cell == nil) {
            cell = [[MBSecondCollectionViewCell alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 140.f)];
        }
        [cell setFrame:CGRectMake(0.f, 0.f, 200.f, 140.f)];
    }
    [cell.textLabel setFrame:cell.bounds];
    [cell.textLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)row]];
    return cell;
}

@end
