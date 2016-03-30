//
//  BossPushTransition.m
//  转场动画练习1
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "BossPushTransition.h"
#import "ViewController.h"
#import "Test1ViewController.h"

@implementation BossPushTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = [transitionContext containerView];
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *tempView = [[UIView alloc] init];
    tempView.frame = [contentView convertRect:fromVC.popRect fromView:fromVC.view];
    tempView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    CGFloat tempViewYScale = CGRectGetMidY(tempView.frame) > CGRectGetMidY(contentView.bounds) ? 2*CGRectGetMidY(tempView.frame)/CGRectGetHeight(tempView.frame) : 2*(CGRectGetHeight(contentView.bounds)-CGRectGetMidY(tempView.frame))/CGRectGetHeight(tempView.bounds);
    
    Test1ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView  *snapShotView = [fromVC.navigationController.view snapshotViewAfterScreenUpdates:NO];
    snapShotView.tag = 4444;
    snapShotView.frame = [contentView convertRect:fromVC.navigationController.view.frame fromView:fromVC.navigationController.view];
    fromVC.view.alpha = 0;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    [contentView addSubview:toVC.view];
    [contentView addSubview:snapShotView];
    [contentView addSubview:tempView];
    
    [UIView animateWithDuration:0.2 animations:^{
        snapShotView.transform = CGAffineTransformMakeScale(0.92, 0.92);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext]-0.2 animations:^{
            tempView.transform = CGAffineTransformMakeScale(1, tempViewYScale);
        } completion:^(BOOL finished) {
            [tempView removeFromSuperview];
            [snapShotView removeFromSuperview];
            toVC.view.alpha = 1.0;
            //添加
            if (toVC.navigationController.view.window) {
                [toVC.navigationController.view.window insertSubview:snapShotView belowSubview:toVC.navigationController.view];
            }
            fromVC.view.alpha = 1.0;
            //告诉系统动画结束
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }];
}


@end
