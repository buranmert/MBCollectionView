//
//  MBNavigationControllerDelegate.m
//  MBCollectionViewExample
//
//  Created by Mert Buran on 28/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBNavigationControllerDelegate.h"
#import "MBTransition.h"

@interface MBNavigationControllerDelegate ()
@property (nonatomic, strong) MBTransition *customTransition;
@end

@implementation MBNavigationControllerDelegate

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _customTransition = [MBTransition new];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop || operation == UINavigationControllerOperationPush) {
        self.customTransition.operationType = operation;
        return self.customTransition;
    }
    else {
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController;
}

@end
