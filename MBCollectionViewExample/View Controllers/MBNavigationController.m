//
//  MBNavigationController.h
//  MBCollectionViewExample
//
//  Created by Mert Buran on 28/03/15.
//  Copyright (c) 2015 Mert Buran. All rights reserved.
//

#import "MBNavigationController.h"
#import "MBNavigationControllerDelegate.h"

@interface MBNavigationController ()

@end

@implementation MBNavigationController

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addPanGestureRecognizer];
}

- (void)addPanGestureRecognizer {
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer {
    MBNavigationControllerDelegate *delegate = (MBNavigationControllerDelegate *)self.delegate;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.view];
        if (location.x <  CGRectGetMidX(self.view.bounds) / 2.f && self.viewControllers.count > 1) { // left edge
            delegate.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(self.view.bounds));
        [delegate.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:self.view].x > 0) {
            [delegate.interactionController finishInteractiveTransition];
        } else {
            [delegate.interactionController cancelInteractiveTransition];
        }
        delegate.interactionController = nil;
    }
}

@end
