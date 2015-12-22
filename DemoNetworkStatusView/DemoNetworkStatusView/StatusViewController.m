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
    
    NSArray *array = @[@"开始"];
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
    
    if (arc4random() % 2 == 0)
    {
        [self.statusView statusloadStart];
    }
    else
    {
        [self.statusView statusloadStartCustom:@"loading..." image:[UIImage imageNamed:@"lock_normal"]];
    }
    [self performSelector:@selector(resultFail) withObject:nil afterDelay:3.0];
}

- (void)resultFail
{
    if (arc4random() % 2 == 0)
    {
        [self.statusView statusloadFailueAndRestart:@"failue" image:[UIImage imageNamed:@"lock_wrong"]];
    }
    else
    {
        [self.statusView statusloadFailueAndRestart:nil image:[UIImage imageNamed:@"lock_wrong"]];
    }
    
    StatusViewController __weak *selfWeak = self;
    self.statusView.buttonClick = ^(){
        NSLog(@"restart");
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    };
}

- (void)resultSuccess
{
    if (arc4random() % 2 == 0)
    {
        [self.statusView statusloadSueccess];
    }
    else
    {
        [self.statusView statusloadSuccessWithoutData:@"success" image:[UIImage imageNamed:@"lock_right"]];
    }
}

@end
