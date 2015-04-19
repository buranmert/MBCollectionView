//
//  MBCollectionView.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 15/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCollectionViewDataSource.h"

@class MBCollectionViewCell;

@interface MBCollectionView : UIView
@property (nonatomic, weak) IBOutlet id<MBCollectionViewDataSource> dataSource;
- (MBCollectionViewCell *)dequeueReusableCellForRow:(MBRow)row forClass:(Class)aClass;
- (void)reloadCollectionViewWithCompletionHandler:(void (^)())completion;
@end
