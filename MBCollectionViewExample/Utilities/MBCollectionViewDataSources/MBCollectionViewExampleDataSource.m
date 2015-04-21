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
#import "MBData.h"

@interface MBCollectionViewExampleDataSource ()
@property (nonatomic, strong) NSArray *dummyDataSource;
@end

@implementation MBCollectionViewExampleDataSource

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        MBData *data = [MBData new];
        data.topText = NSLocalizedString(@"THIS IS TOP LABEL THIS IS TOP LABEL THIS IS TOP LABEL THIS IS TOP LABEL THIS IS TOP LABEL THIS IS TOP LABEL THIS IS TOP LABEL THIS IS TOP LABEL", @"Configuring Cell");
        data.bottomText = NSLocalizedString(@"THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL THIS IS BOTTOM LABEL", @"Configuring Cell");
        data.image = [UIImage imageNamed:@"Lena"];
        _dummyDataSource = [NSArray arrayWithObject:data];
    }
    return self;
}

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
    [cell setText:data.topText forLabelPosition:MBCellLabelPositionTop];
    [cell setText:data.bottomText forLabelPosition:MBCellLabelPositionBottom];
    [cell setImage:data.image];
}

- (MBData *)getDataForRow:(MBRow)row {
    MBData *data = [self.dummyDataSource firstObject];
    return data;
}

@end
