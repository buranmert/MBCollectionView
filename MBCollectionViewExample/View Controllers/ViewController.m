//
//  ViewController.m
//  MBCollectionViewExample
//
//  Created by Mert Buran on 15/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "ViewController.h"
#import "MBDetailViewController.h"
#import "MBCollectionView.h"
#import "MBCollectionViewCell.h"
#import "MBCollectionViewDelegate.h"
#import "MBCollectionViewExampleDataSource.h"

static NSString * const kDetailPushSegueIdentifier = @"detailPushSegue";

@interface ViewController () <MBCollectionViewDelegate>
@property (nonatomic, strong) MBData *dataToPass;
@end

@implementation ViewController

- (void)collectionView:(MBCollectionView *)collectionView didTapOnCell:(MBCollectionViewCell *)cell {
    MBCollectionViewExampleDataSource *dataSource = collectionView.dataSource;
    MBData *data = [dataSource getDataForRow:cell.rowIndex];
    self.dataToPass = data;
    [self performSegueWithIdentifier:kDetailPushSegueIdentifier sender:self];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([[segue identifier] isEqualToString:kDetailPushSegueIdentifier]) {
         MBDetailViewController *detailViewController = [segue destinationViewController];
         [detailViewController setDetailData:self.dataToPass];
         self.dataToPass = nil;
     }
 }
 

@end
