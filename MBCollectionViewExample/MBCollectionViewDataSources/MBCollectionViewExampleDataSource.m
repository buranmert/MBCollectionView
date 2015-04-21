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
#import "MBCollectionViewFirstXibCell.h"

@interface MBData : NSObject
@end
@implementation MBData
@end

@implementation MBCollectionViewExampleDataSource

- (MBRow)rowCount {
    return 40;
}

- (MBCollectionViewCell *)collectionView:(MBCollectionView *)collectionView viewForRow:(MBRow)row {
    MBCollectionViewFirstXibCell *cell;
    cell = (MBCollectionViewFirstXibCell *)[collectionView dequeueReusableCellForRow:row forClass:[MBCollectionViewFirstXibCell class]];
    if (cell == nil) {
        cell = [MBCollectionViewFirstXibCell initWithNibOfCell];
    }
    [cell setCellMode:(row % 2 ? MBCellModeMapView : MBCellModeImageView)];
    MBData *dataForRow = [self getDataForRow:row];
    [self configureCell:cell withData:dataForRow];
    [cell sizeToFit];
    return cell;
}

- (void)configureCell:(MBCollectionViewFirstXibCell *)cell withData:(MBData *)data {
    [cell setText:NSLocalizedString(@"THIS IS TOP LABEL THIS IS TOP LABEL THIS IS TOP LABEL THIS IS TOP LABEL", @"Configuring Cell") forLabelPosition:MBCellLabelPositionTop];
    [cell setText:NSLocalizedString(@"THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL", @"Configuring Cell") forLabelPosition:MBCellLabelPositionBottom];
    [cell setImage:[UIImage imageNamed:@"Lena"]];
}

- (MBData *)getDataForRow:(MBRow)row {
    MBData *data = [MBData new];
    return data;
}

@end
