//
//  Test1ViewController.m
//  转场动画练习1
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "Test1ViewController.h"
#import "BossPopTransition.h"
#import "BossClosePopTransition.h"

@interface Test1ViewController () <UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *buttonBGView;

@property (nonatomic, assign) CGFloat currentCompleted;
@property (nonatomic, assign) BOOL isDismissAnimation;

@end

@implementation Test1ViewController

//-(void)dealloc {
//    NSLog(@"Test1ViewController dealloc!");
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self creatCustomNavigationItems];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.title = @"iOS";
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}


- (void)creatCustomNavigationItems {
    //左按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItems = @[item];
}
- (void)leftbarButtonClick:(UIButton *)button {
    self.isDismissAnimation = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-64-60) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
        //当你需要调试时 请打开注释
        //self.view.backgroundColor = [UIColor yellowColor];
        
        self.buttonBGView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-60, CGRectGetWidth(self.view.bounds), 60)];
        self.buttonBGView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_buttonBGView];
    }
}

#pragma mark ==== UITableViewDelegate && UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Test1CellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Test1CellID"];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld行",(long)indexPath.row];
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 75;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat begainY = scrollView.contentSize.height-CGRectGetHeight(scrollView.bounds);
   // MIN(0, begainY-scrollView.contentOffset.y) == -MAX(0, (scrollView.contentOffset.y - begainY))
    CGFloat offsetY = MIN(0, begainY-scrollView.contentOffset.y);
    self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight([UIScreen mainScreen].bounds)+offsetY);
    self.buttonBGView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-60+offsetY,CGRectGetWidth(self.buttonBGView.bounds), 60);
    //CGRectGetHeight([UIScreen mainScreen].bounds) 这里给出一个常量 来计算 比例
    self.currentCompleted = MIN(MAX(0, fabs(offsetY)/200), 1);
    
    if (scrollView.contentOffset.y>=scrollView.contentSize.height-CGRectGetHeight(scrollView.bounds)+100) {
        //这里你可以加入断点 然后点击 `Debug View Hierarchy` 按钮 查看视图的层级 方便调试 更详细的 调试请自行查找
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_currentCompleted > 0.55) {
        self.isDismissAnimation = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (!_isDismissAnimation) {
        BossPopTransition *inverseTransition = [[BossPopTransition alloc]init];
        return inverseTransition;
    }else {
        BossClosePopTransition *dismissTransition = [[BossClosePopTransition alloc] init];
        return dismissTransition;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
