//
//  ViewController.m
//  DemoNetworkStatusView
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYMessageView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)setUI
{
    self.array = @[@"居上（无圆角）", @"居上（圆角，自适应）", @"居中（圆角，自适应）", @"居下（圆角，自适应）"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NSString *text = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row)
    {
        [[SYMessageView shareManager] setColorForBackground:[UIColor greenColor]];
        [SYMessageView shareManager].messageLabel.textColor = [UIColor redColor];
        [[SYMessageView shareManager] showWithView:self.view position:PositionTop message:@"没有网络，请检查网络设置" image:[UIImage imageNamed:@"lock_wrong"] animation:YES];
    }
    else if (1 == indexPath.row)
    {
        [[SYMessageView shareManager] showWithView:self.view position:PositionTopRountAdjust message:@"没有网络，请检查网络设置" image:[UIImage imageNamed:@"lock_wrong"] animation:YES];
    }
    else if (2 == indexPath.row)
    {
        [[SYMessageView shareManager] showWithView:self.view position:PositionCenterRountAdjust message:@"没有网络，请检查网络设置" image:nil animation:YES];
    }
    else if (3 == indexPath.row)
    {
        [[SYMessageView shareManager] showWithView:self.view position:PositionBottomRountAdjust message:@"您还没有连接网络，请检查外部网络设置" image:nil animationTime:2.0 animation:YES];
    }
}


@end
