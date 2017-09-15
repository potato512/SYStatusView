//
//  SYNetworkStatusView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYNetworkStatusView.h"

#define widthMainScreen  [UIScreen mainScreen].bounds.size.width
#define heightMainScreen [UIScreen mainScreen].bounds.size.height
#define viewWindow       [[UIApplication sharedApplication].delegate window]

#define widthSelf  bgroundView.frame.size.width
#define heightSelf bgroundView.frame.size.height

static CGFloat const originXY     = 10.0;
static CGFloat const heightlabel  = 30.0;
static CGFloat const widthButton  = 60.0;
static CGFloat const heightButton = 25.0;

@interface SYNetworkStatusView ()
{
    UIView *bgroundView;
    BOOL isReloadFrame;
}

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, assign) BOOL isActivity;
@property (nonatomic, strong) NSArray <UIImage *> *images;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *messagelabel;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) void (^clickBlock)(void);

@end

@implementation SYNetworkStatusView

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        [self setUI:view];
        
        // 初始化信息
        _showButtonFullScreen = NO;
        _sizeImage = CGSizeMake(120.0, 120.0);
        _animationTime = 0.6;
        
        isReloadFrame = NO;
    }
    
    return self;
}

#pragma mark - 视图

- (void)setUI:(UIView *)view
{
    if (!self.superView && view)
    {
        self.superView = view;
        
        self.frame = view.bounds;
        [view addSubview:self];
        self.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
        
        self.backgroundColor = view.backgroundColor;
        
        bgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:bgroundView];
        bgroundView.backgroundColor = self.backgroundColor;
    }
}

- (void)resetUI
{
    if (!self.superview)
    {
        [self.superView addSubview:self];
    }
    [self.superView bringSubviewToFront:self];
    
    self.activityView.hidden = YES;
    self.imageView.hidden = YES;
    self.messagelabel.hidden = YES;
    self.button.hidden = YES;
}

- (void)resetUI:(NSString *)message image:(NSArray <UIImage *> *)images
{
    [self resetUI];
    
    // 图标
    if (images && 0 < images.count)
    {
        self.imageView.hidden = NO;
        
        if (1 == images.count)
        {
            self.imageView.image = images.firstObject;
            
            if ([self.imageView isAnimating])
            {
                [self.imageView stopAnimating];
                self.imageView.animationImages = nil;
            }
        }
        else if (1 < images.count)
        {
            self.imageView.animationDuration = _animationTime;
            self.imageView.animationImages = images;
            [self.imageView startAnimating];
            
            self.imageView.image = nil;
        }
    }
    
    // 提示语
    if (message && 0 < message.length)
    {
        self.messagelabel.hidden = NO;
        
        self.messagelabel.text = message;
    }
}

- (void)reloadUIFrame
{
    if (self.activityView.hidden)
    {
        CGFloat heightTotal = 0.0;
        if (!self.imageView.hidden)
        {
            CGRect rectImage = self.imageView.frame;
            rectImage.size = self.sizeImage;
            rectImage.origin.x = (widthSelf - self.sizeImage.width) / 2;
            self.imageView.frame = rectImage;
            
            heightTotal += self.imageView.frame.size.height;
        }
        if (!self.messagelabel.hidden)
        {
            heightTotal += self.messagelabel.frame.size.height;
        }
        if (!self.button.hidden && !self.showButtonFullScreen)
        {
            heightTotal += self.button.frame.size.height;
        }
        
        CGFloat originYTotal = (isReloadFrame ? 0.0 : (heightSelf - heightTotal) / 2);
        UIView *currentView = nil;
        if (!self.imageView.hidden)
        {
            CGRect rectImage = self.imageView.frame;
            rectImage.origin.y = originYTotal;
            self.imageView.frame = rectImage;
            
            currentView = self.imageView;
        }
        if (!self.messagelabel.hidden)
        {
            CGRect rectLabel = self.messagelabel.frame;
            rectLabel.origin.y = originYTotal;
            if (!self.imageView.hidden)
            {
                rectLabel.origin.y = (currentView.frame.origin.y + currentView.frame.size.height);
            }
            self.messagelabel.frame = rectLabel;
            
            currentView = self.messagelabel;
        }
        if (!self.button.hidden)
        {
            CGRect rectButton = self.button.frame;
            if (self.showButtonFullScreen)
            {
                rectButton = self.bounds;
                
                self.button.layer.cornerRadius = 0.0;
                self.button.layer.borderColor = [UIColor clearColor].CGColor;
                self.button.layer.borderWidth = 0.0;
                [self.button setTitle:@"" forState:UIControlStateNormal];
            }
            else
            {
                rectButton.origin.y = originYTotal;
                if (!self.imageView.hidden || !self.messagelabel.hidden)
                {
                    rectButton.origin.y = (currentView.frame.origin.y + currentView.frame.size.height);
                }
            }
            self.button.frame = rectButton;
        }
    }
    else
    {
        self.activityView.center = CGPointMake(widthSelf / 2, (isReloadFrame ? 0.0 : heightSelf / 2));
    }
}

/// 重置视图位置与大小
- (void)reloadFrame:(CGRect)rect
{
    bgroundView.frame = rect;
    isReloadFrame = YES;
    
    [self reloadUIFrame];
}

#pragma mark - 状态

#pragma mark 开始

// 开始（菊花转）
- (void)loadStart
{
    [self resetUI];
    
    self.isActivity = YES;

    [self.activityView startAnimating];
    self.activityView.hidden = NO;
    
    [self reloadUIFrame];
}

// 开始（自定义）
- (void)loadStart:(NSString *)message image:(NSArray <UIImage *> *)images
{
    self.message = message;
    self.images = images;
    
    [self resetUI:message image:images];
    
    [self reloadUIFrame];
}

#pragma mark 成功

// 结束，加载成功
- (void)loadSueccess
{
    if (self.isActivity)
    {
        if ([self.activityView isAnimating])
        {
            [self.activityView stopAnimating];
        }
    }
    else
    {
        if ([self.imageView isAnimating])
        {
            [self.imageView stopAnimating];
        }
    }
    
    if (self.superview)
    {
        [self removeFromSuperview];
    }
}

// 结束，加载成功，无数据
- (void)loadSuccessWithoutData:(NSString *)message image:(NSArray<UIImage *> *)images
{
    [self resetUI:message image:images];
    
    [self reloadUIFrame];
}

// 结束，加载成功，无数据，重新加载
- (void)loadSuccessWithoutData:(NSString *)message image:(NSArray<UIImage *> *)images click:(void (^)(void))click
{
    [self resetUI:message image:images];
    
    self.button.hidden = NO;
    self.clickBlock = [click copy];

    [self reloadUIFrame];
}

#pragma mark 失败

// 结束，加载失败
- (void)loadFailue:(NSString *)message image:(NSArray<UIImage *> *)images
{
    [self resetUI:message image:images];
    
    [self reloadUIFrame];
}

- (void)loadFailue:(NSString *)message image:(NSArray<UIImage *> *)images click:(void (^)(void))click
{
    [self resetUI:message image:images];
    
    self.button.hidden = NO;
    self.clickBlock = [click copy];
    
    [self reloadUIFrame];
}

#pragma mark - 响应

- (void)buttonClick:(UIButton *)button
{
    if (self.isActivity)
    {
        [self loadStart];
    }
    else
    {
        [self loadStart:self.message image:self.images];
    }
    
    if (self.clickBlock)
    {
        self.clickBlock();
    }
}

#pragma mark - setter

#pragma mark - getter

- (UIActivityIndicatorView *)activityView
{
    if (_activityView == nil)
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.backgroundColor = [UIColor clearColor];
        
        [bgroundView addSubview:_activityView];
        
        _activityView.color = [UIColor redColor];
    }
    
    return _activityView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        
        [bgroundView addSubview:_imageView];
        _imageView.frame = CGRectMake((widthSelf - self.sizeImage.width) / 2, 0.0, self.sizeImage.width, self.sizeImage.height);
        
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return _imageView;
}

- (UILabel *)messagelabel
{
    if (_messagelabel == nil)
    {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.backgroundColor = [UIColor clearColor];
        
        [bgroundView addSubview:_messagelabel];
        _messagelabel.frame = CGRectMake(originXY, 0.0, (widthSelf - originXY * 2), heightlabel);
        
        _messagelabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _messagelabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _messagelabel;
}

- (UIButton *)button
{
    if (_button == nil)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor clearColor];
        
        [bgroundView addSubview:_button];
        _button.frame = CGRectMake(((widthSelf - widthButton) / 2), 0.0, widthButton, heightButton);
        
        _button.layer.cornerRadius = 5.0;
        _button.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
        _button.layer.borderWidth = 0.5;
        _button.layer.masksToBounds = YES;
        
        [_button setTitle:@"重新加载" forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_button setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.5] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.2] forState:UIControlStateHighlighted];
        
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (UIButton *)reloadButton
{
    return self.button;
}

- (UILabel *)messageLabel
{
    return self.messagelabel;
}

@end
