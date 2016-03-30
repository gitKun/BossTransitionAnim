//
//  ViewController.m
//  BossTransitionAnim
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "ViewController.h"
#import "BossPushTransition.h"
#import "UIView+Corner.h"

@interface ViewController ()<UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *popAnimBtn;
@property (weak, nonatomic) IBOutlet UIView *markView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_title"] forBarMetrics:UIBarMetricsDefault];
    [self creatCustomLeftBarButton];
}
- (void)creatCustomLeftBarButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"bar_notice"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[item];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)viewDidLayoutSubviews {
    if (!self.popAnimBtn.hasDRCornered) {
        [self.popAnimBtn dr_cornerWithRadius:20 backgroundColor:self.view.backgroundColor];
        [self.markView dr_cornerWithRadius:15 backgroundColor:self.view.backgroundColor];
    }
}

- (IBAction)popAnimationBtnClick:(UIButton *)sender {
    CGRect popRect = [self.view convertRect:sender.frame toView:self.view];
    //NSLog(@"popRect = %@",NSStringFromCGRect(popRect));
    self.popRect = popRect;
    
    [self performSegueWithIdentifier:@"pushAnim" sender:self];
    
}

#pragma mark ==== UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    return [BossPushTransition new];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end