//
//  StatusViewController.m
//  DemoNetworkStatusView
//
//  Created by zhangshaoyu on 15/11/8.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "StatusViewController.h"
#import "SYNetworkStatusView.h"

@interface StatusViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) SYNetworkStatusView *statusView;

@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"网络状态视图";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:self action:@selector(reloadClick)];
    
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

- (void)dealloc
{
    NSLog(@"<----%@ 调用了 %s---->", [self class], __func__);
}

- (void)setUI
{
    NSArray *arrayRow = @[@"成功", @"成功无数据：单图标", @"成功无数据：多图标", @"成功无数据：提示语", @"成功无数据：单图标+提示语", @"成功无数据：多图标+提示语", @"成功无数据：刷新", @"成功无数据：单图标+刷新", @"成功无数据：多图标+刷新", @"成功无数据：提示语+刷新", @"成功无数据：单图标+提示语+刷新", @"成功无数据：多图标+提示语+刷新", @"失败：单图标", @"失败：多图标", @"失败：提示语", @"失败：单图标+提示语",  @"失败：多图标+提示语", @"失败：刷新", @"失败：单图标+刷新", @"失败：多图标+刷新", @"失败：提示语+刷新", @"失败：单图标+提示语+刷新", @"失败：多图标+提示语+刷新"];
    NSDictionary *dict01 = @{@"name":@"菊花转开始", @"values":arrayRow};
    NSDictionary *dict02 = @{@"name":@"单图标开始", @"values":arrayRow};
    NSDictionary *dict03 = @{@"name":@"多图标开始", @"values":arrayRow};
    NSDictionary *dict04 = @{@"name":@"提示语开始", @"values":arrayRow};
    NSDictionary *dict05 = @{@"name":@"单图标+提示语开始", @"values":arrayRow};
    NSDictionary *dict06 = @{@"name":@"多图标+提示语开始", @"values":arrayRow};
    self.array = @[dict01, dict02, dict03, dict04, dict05, dict06];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (void)reloadClick
{
    [self.statusView loadSueccess];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = self.array[section];
    NSString *title = dict[@"name"];
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = self.array[section];
    NSArray *arrayRow = dict[@"values"];
    return arrayRow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NSDictionary *dict = self.array[indexPath.section];
    NSArray *arrayRow = dict[@"values"];
    NSString *text = [arrayRow objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.section)
    {
        self.statusView.sizeImage = CGSizeMake(80.0, 80.0);
        [self.statusView reloadFrame:CGRectMake((self.view.frame.size.width - 200.0) / 2, 100.0, 200.0, 200.0)];
        [self.statusView loadStart];
    }
    else if (1 == indexPath.section)
    {
        [self.statusView loadStart:nil image:@[[UIImage imageNamed:@"lock_normal"]]];
    }
    else if (2 == indexPath.section)
    {
        [self.statusView.reloadButton setTitle:@"再次刷新" forState:UIControlStateNormal];
        [self.statusView.reloadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.statusView.reloadButton setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
        self.statusView.messageLabel.textColor = [UIColor redColor];
        [self.statusView loadStart:nil image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]]];
    }
    else if (3 == indexPath.section)
    {
        [self.statusView loadStart:@"加载中..." image:nil];
    }
    else if (4 == indexPath.section)
    {
        [self.statusView loadStart:@"加载中..." image:@[[UIImage imageNamed:@"lock_normal"]]];
    }
    else if (5 == indexPath.section)
    {
        self.statusView.showButtonFullScreen = YES;
        [self.statusView loadStart:@"加载中..." image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]]];
    }
    
    if (0 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }
    else if (1 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataImage) withObject:nil afterDelay:3.0];
    }
    else if (2 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataImages) withObject:nil afterDelay:3.0];
    }
    else if (3 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataMessage) withObject:nil afterDelay:3.0];
    }
    else if (4 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataImageMessage) withObject:nil afterDelay:3.0];
    }
    else if (5 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataImagesMessage) withObject:nil afterDelay:3.0];
    }
    else if (6 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataReload) withObject:nil afterDelay:3.0];
    }
    else if (7 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataReloadImage) withObject:nil afterDelay:3.0];
    }
    else if (8 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataReloadImages) withObject:nil afterDelay:3.0];
    }
    else if (9 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataReloadMessage) withObject:nil afterDelay:3.0];
    }
    else if (10 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataReloadImageMessage) withObject:nil afterDelay:3.0];
    }
    else if (11 == indexPath.row)
    {
        [self performSelector:@selector(resultSuccessWithoutDataReloadImagesMessage) withObject:nil afterDelay:3.0];
    }
    else if (12 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileImage) withObject:nil afterDelay:3.0];
    }
    else if (13 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileImages) withObject:nil afterDelay:3.0];
    }
    else if (14 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileMessage) withObject:nil afterDelay:3.0];
    }
    else if (15 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileImageMessage) withObject:nil afterDelay:3.0];
    }
    else if (16 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileImagesMessage) withObject:nil afterDelay:3.0];
    }
    else if (17 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileReload) withObject:nil afterDelay:3.0];
    }
    else if (18 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileReloadImage) withObject:nil afterDelay:3.0];
    }
    else if (19 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileReloadImages) withObject:nil afterDelay:3.0];
    }
    else if (20 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileReloadMessage) withObject:nil afterDelay:3.0];
    }
    else if (21 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileReloadImageMessage) withObject:nil afterDelay:3.0];
    }
    else if (22 == indexPath.row)
    {
        [self performSelector:@selector(resultFaileReloadImagesMessage) withObject:nil afterDelay:3.0];
    }
}


- (SYNetworkStatusView *)statusView
{
    if (_statusView == nil)
    {
        _statusView = [[SYNetworkStatusView alloc] initWithView:self.view];
    }
    return _statusView;
}

- (void)resultSuccess
{
    [self.statusView loadSueccess];
}

- (void)resultSuccessWithoutDataImage
{
    [self.statusView loadSuccessWithoutData:nil image:@[[UIImage imageNamed:@"lock_normal"]]];
}

- (void)resultSuccessWithoutDataImages
{
    self.statusView.animationTime = 1.0;
    [self.statusView loadSuccessWithoutData:nil image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]]];
}

- (void)resultSuccessWithoutDataMessage
{
    [self.statusView loadSuccessWithoutData:@"没有数据" image:nil];
}

- (void)resultSuccessWithoutDataImageMessage
{
    [self.statusView loadSuccessWithoutData:@"没有数据" image:@[[UIImage imageNamed:@"lock_normal"]]];
}

- (void)resultSuccessWithoutDataImagesMessage
{
    [self.statusView loadSuccessWithoutData:@"没有数据" image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]]];
}

- (void)resultSuccessWithoutDataReload
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadSuccessWithoutData:nil image:nil click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultSuccessWithoutDataReloadImage
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadSuccessWithoutData:nil image:@[[UIImage imageNamed:@"lock_normal"]] click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultSuccessWithoutDataReloadImages
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadSuccessWithoutData:nil image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]] click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultSuccessWithoutDataReloadMessage
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadSuccessWithoutData:@"没有数据" image:nil click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultSuccessWithoutDataReloadImageMessage
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadSuccessWithoutData:@"没有数据" image:@[[UIImage imageNamed:@"lock_normal"]] click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultSuccessWithoutDataReloadImagesMessage
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadSuccessWithoutData:@"没有数据" image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]] click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultFaileImage
{
    [self.statusView loadFailue:nil image:@[[UIImage imageNamed:@"lock_normal"]]];
}

- (void)resultFaileImages
{
    [self.statusView loadFailue:nil image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]]];
}

- (void)resultFaileMessage
{
    [self.statusView loadFailue:@"加载失败" image:nil];
}

- (void)resultFaileImageMessage
{
    [self.statusView loadFailue:@"加载失败" image:@[[UIImage imageNamed:@"lock_normal"]]];
}

- (void)resultFaileImagesMessage
{
    [self.statusView loadFailue:@"加载失败" image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]]];
}

- (void)resultFaileReload
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadFailue:nil image:nil click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultFaileReloadImage
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadFailue:nil image:@[[UIImage imageNamed:@"lock_normal"]] click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultFaileReloadImages
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadFailue:nil image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]] click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultFaileReloadMessage
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadFailue:@"加载失败" image:nil click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultFaileReloadImageMessage
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadFailue:@"加载失败" image:@[[UIImage imageNamed:@"lock_normal"]] click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

- (void)resultFaileReloadImagesMessage
{
    StatusViewController __weak *selfWeak = self;
    
    [self.statusView loadFailue:@"加载失败" image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]] click:^{
        [selfWeak performSelector:@selector(resultSuccess) withObject:nil afterDelay:3.0];
    }];
}

@end
