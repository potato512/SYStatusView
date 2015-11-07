//
//  StatusViewController.m
//  DemoNetworkStatusView
//
//  Created by zhangshaoyu on 15/11/8.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "StatusViewController.h"
#import "SYNetworkStatusView.h"

@interface StatusViewController ()

@property (nonatomic, strong) SYNetworkStatusView *statusView;

@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"网络状态视图";
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    NSArray *array = @[@"开始", @"开始自定义", @"成功", @"成功无数据", @"失败", @"失败重新开始"];
    NSInteger count = array.count;
    for (int i = 0; i < count; i++)
    {
        NSString *title = array[i];
        CGRect rect = CGRectMake(10.0, (i * (40.0 + 10.0)) + 10.0, CGRectGetWidth(self.view.bounds) - 10.0 * 2, 40.0);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.frame = rect;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClick:(UIButton *)button
{
    if (!self.statusView)
    {
        self.statusView = [[SYNetworkStatusView alloc] initWithView:self.view];
    }
    
    NSInteger index = button.tag;
    if (0 == index)
    {
        [self.statusView statusloadStart];
        [self performSelector:@selector(failueRestart) withObject:nil afterDelay:3.0];
    }
    else if (1 == index)
    {
        [self.statusView statusloadStartCustom:@"loading..." image:[UIImage imageNamed:@"lock_normal"]];
//        [self.statusView statusloadStartCustom:nil image:[UIImage imageNamed:@"lock_normal"]];
        [self performSelector:@selector(failueRestart) withObject:nil afterDelay:3.0];
    }
    else if (2 == index)
    {
        [self.statusView statusloadSueccess];
    }
    else if (3 == index)
    {
        [self.statusView statusloadSuccessWithoutData:@"success" image:[UIImage imageNamed:@"lock_right"]];
//        [self.statusView statusloadSuccessWithoutData:nil image:[UIImage imageNamed:@"lock_right"]];
    }
    else if (4 == index)
    {
        [self.statusView statusloadFailue:@"failue" image:[UIImage imageNamed:@"lock_wrong"]];
//        [self.statusView statusloadFailue:nil image:[UIImage imageNamed:@"lock_wrong"]];
    }
    else if (5 == index)
    {
//        [self.statusView statusloadFailueAndRestart:@"failue" image:[UIImage imageNamed:@"lock_wrong"]];
        [self.statusView statusloadFailueAndRestart:nil image:[UIImage imageNamed:@"lock_wrong"]];
        self.statusView.buttonClick = ^(){
            NSLog(@"restart");
        };
    }
}

- (void)failueRestart
{
    [self.statusView statusloadFailueAndRestart:@"failue" image:[UIImage imageNamed:@"lock_wrong"]];
//    [self.statusView statusloadFailueAndRestart:nil image:[UIImage imageNamed:@"lock_wrong"]];
    StatusViewController __weak *selfWeak = self;
    self.statusView.buttonClick = ^(){
        NSLog(@"restart");
        [selfWeak performSelector:@selector(failueRestart) withObject:nil afterDelay:3.0];
    };
}

@end
