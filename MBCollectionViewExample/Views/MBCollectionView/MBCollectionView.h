//
//  MBCollectionView.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 15/04/2015.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCollectionViewDataSource.h"
#import "MBCollectionViewDelegate.h"

@interface MBCollectionViewCell (MBCollectionViewExtension)
/*
 cell provide index information (but it must be read-only to avoid wrong index values)
 */
//@property (nonatomic, readonly) MBRow rowIndex;
@end

@interface MBCollectionView : UIView
@property (nonatomic, weak) IBOutlet id<MBCollectionViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<MBCollectionViewDelegate> delegate;

/*
 dequeues reusable cells from internal cell view pool. dequeued cells call their prepareForReuse method
 */
- (MBCollectionViewCell *)dequeueReusableCellForRow:(MBRow)row forClass:(Class)aClass;

/*
 removes all cells and draws them from the beginning. as cells are drawn again, completion block is executed if it is not nil
 */
- (void)reloadCollectionViewWithCompletionHandler:(void (^)())completion;
@end
