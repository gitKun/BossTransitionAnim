//
//  BossClosePopTransition.m
//  转场动画练习1
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "BossClosePopTransition.h"

@implementation BossClosePopTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    UIWindow *window = fromVC.navigationController.view.window;
    UIView *tempView = [window viewWithTag:4444];
    [tempView removeFromSuperview];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = CGRectMake(0, CGRectGetHeight(fromVC.view.bounds), CGRectGetWidth(fromVC.view.bounds), CGRectGetHeight(fromVC.view.bounds));
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
