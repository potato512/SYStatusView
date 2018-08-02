//
//  SYMessageView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//  没有网络时的提示

#import <UIKit/UIKit.h>

/// 显示位置模式（偏上，居中，偏下）
typedef NS_ENUM(NSInteger, PositionMode)
{
    /// 居上（无圆角）
    PositionTop = 0,
    
    /// 居上（圆角，自适应）
    PositionTopRountAdjust = 1,
    
    /// 居中（圆角，自适应）
    PositionCenterRountAdjust = 2,
    
    /// 居下（圆角，自适应）
    PositionBottomRountAdjust = 3,
};

@interface SYMessageView : UIView

/// 单例
+ (instancetype)shareManager;

/// 背景颜色
@property (nonatomic, strong) UIColor *colorForBackground;
/// 信息标签
@property (nonatomic, strong) UILabel *messageLabel;

/// 显示状态提示（父视图、位置、提示语、图标、动画时间、动画显示）
- (void)showWithView:(UIView *)view position:(PositionMode)posttion message:(NSString *)message image:(UIImage *)image animationTime:(NSTimeInterval)time animation:(BOOL)animation;

/// 显示状态提示（父视图、位置、提示语、图标、动画显示）-默认0.3秒动画
- (void)showWithView:(UIView *)view position:(PositionMode)posttion message:(NSString *)message image:(UIImage *)image animation:(BOOL)animation;

/// 隐藏
- (void)hidden;

@end
