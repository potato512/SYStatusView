//
//  SYNetworkStatusView.h
//  DemoNetworkStatusView
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  网络加载视图控件（开始加载时，加载结束（或功，或失败，或空数据）、加载异常重新加载、加载无网络）

#import <UIKit/UIKit.h>

@interface SYNetworkStatusView : UIView

/// 实例化
- (instancetype)initWithView:(UIView *)view;


/// 开始（菊花转）
- (void)statusloadStart;

/// 开始（自定义）
- (void)statusloadStartCustom:(NSString *)message image:(UIImage *)image;

/// 结束，加载成功
- (void)statusloadSueccess;

/// 结束，加载成功，无数据
- (void)statusloadSuccessWithoutData:(NSString *)message image:(UIImage *)image;

/// 结束，加载失败
- (void)statusloadFailue:(NSString *)message image:(UIImage *)image;

/// 结束，加载失败（重新加载）
- (void)statusloadFailueAndRestart:(NSString *)message image:(UIImage *)image;


/// 重新加载时响应回调
@property (nonatomic, copy) void (^buttonClick)(void);

@end
