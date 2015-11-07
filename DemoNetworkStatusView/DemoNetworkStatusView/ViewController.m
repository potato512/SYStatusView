//
//  ViewController.m
//  DemoNetworkStatusView
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYWithoutNetworkView.h"
#import "StatusViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"网络状态视图";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"withoutNetwork" style:UIBarButtonItemStyleDone target:self action:@selector(withoutNetwork)];
    
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
    
    NSArray *array = @[@"StatusViewController"];
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

- (void)withoutNetwork
{
    [[SYWithoutNetworkView shareManager] showWithView:self.view position:PositionTopRountAdjust message:@"没有网络，请检查网络设置" image:[UIImage imageNamed:@"lock_wrong"] animation:YES];
}

- (void)buttonClick:(UIButton *)button
{
    StatusViewController *vc = [[StatusViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
