//
//  BossPopTransition.m
//  转场动画练习1
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "BossPopTransition.h"

@implementation BossPopTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.transform = CGAffineTransformMakeScale(0.92, 0.92);
    //toVC.view.alpha = 0;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView  *snapShotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:fromVC.view.frame fromView:fromVC.view];
    fromVC.view.hidden = YES;
    
    [containerView addSubview:snapShotView];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    UIWindow *window = fromVC.navigationController.view.window;
    UIView *tempView = [window viewWithTag:4444];
    [tempView removeFromSuperview];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]-0.1 animations:^{
        snapShotView.frame = CGRectMake(0, -CGRectGetHeight(snapShotView.frame), CGRectGetWidth(snapShotView.frame), CGRectGetHeight(snapShotView.frame));
       
    } completion:^(BOOL finished) {
        //toVC.view.alpha = 1.0;
        [snapShotView removeFromSuperview];
        [UIView animateWithDuration:0.1 animations:^{
            toVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}

@end
