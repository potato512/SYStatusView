//
//  SYNetworkStatusView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  状态视图控件（开始加载时，加载结束（或功，或失败，或空数据）、加载异常重新加载、加载无网络）

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SYNetworkStatusView : UIView

/**
 *  实例化
 *
 *  @param view 父视图
 *
 *  @return 实例
 */
- (instancetype)initWithView:(UIView *)view;

/// 图标大小
@property (nonatomic, assign) CGSize sizeImage;
// 按钮全屏（默认：NO；全屏时，标题无效，点透明）
@property (nonatomic, assign) BOOL showButtonFullScreen;
/// 多图时的动画时间（默认：0.6）
@property (nonatomic, assign) NSTimeInterval animationTime;
/// 标题属性设置（字体大小、字体颜色等）
@property (nonatomic, strong, readonly) UILabel *messageLabel;
/// 按钮属性设置（字体大小、字体颜色等）
@property (nonatomic, strong, readonly) UIButton *reloadButton;

/// 重置视图位置与大小
- (void)reloadFrame:(CGRect)rect;


/**
 *  开始（默认：菊花转）
 */
- (void)loadStart;
/**
 *  开始（自定义：提示语、图标）
 *
 *  @param message 提示语
 *  @param images  图标数组
 */
- (void)loadStart:(NSString *)message image:(NSArray <UIImage *> *)images;

/**
 *  结束，加载成功（默认：无提示语、无图标）
 */
- (void)loadSueccess;
/**
 *  结束，加载成功，无数据（自定义：提示语、图标；无重新加载）
 *
 *  @param message 提示语
 *  @param images  图标数组
 */
- (void)loadSuccessWithoutData:(NSString *)message image:(NSArray <UIImage *> *)images;
/**
 *  结束，加载成功，无数据（自定义：提示语、图标；重新加载）
 *
 *  @param message 提示语
 *  @param images  图标数组
 *  @param click   重新加载
 */
- (void)loadSuccessWithoutData:(NSString *)message image:(NSArray <UIImage *> *)images click:(void (^)(void))click;

/**
 *  结束，加载失败（自定义：提示语、图标；无重新加载）
 *
 *  @param message 提示语
 *  @param images  图标数组
 */
- (void)loadFailue:(NSString *)message image:(NSArray <UIImage *> *)images;
/**
 *  结束，加载失败（自定义：提示语、图标；重新加载）
 *
 *  @param message 提示语
 *  @param images  图标数组
 *  @param click   重新加载
 */
- (void)loadFailue:(NSString *)message image:(NSArray <UIImage *> *)images click:(void (^)(void))click;


@end
