//
//  SYNetworkStatusView.m
//  DemoNetworkStatusView
//
//  Created by zhangshaoyu on 15/11/7.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYNetworkStatusView.h"

#define widthMainScreen  [UIScreen mainScreen].bounds.size.width
#define heightMainScreen [UIScreen mainScreen].bounds.size.height
#define viewWindow       [[UIApplication sharedApplication].delegate window]

static CGFloat const originXY     = 0.0;
static CGFloat const sizeImage    = 120.0;
static CGFloat const heightlabel  = 40.0;
static CGFloat const widthButton  = 60.0;
static CGFloat const heightButton = 20.0;
#define originY                    ((CGRectGetHeight(self.bounds) - sizeImage) / 2)
#define originyWithMessage         ((CGRectGetHeight(self.bounds) - (sizeImage + heightlabel + originXY)) / 2)
#define originyWithButton          ((CGRectGetHeight(self.bounds) - (sizeImage + heightButton + originXY)) / 2)
#define originYWithMessageAndButon ((CGRectGetHeight(self.bounds) - (sizeImage + heightlabel + originXY * 2 + heightButton)) / 2)

@interface SYNetworkStatusView ()

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, assign) BOOL isActivity;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *messagelabel;
@property (nonatomic, strong) UIButton *reStartButton;

@end

@implementation SYNetworkStatusView

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        [self setUI:view];
    }
    
    return self;
}

- (void)setUI:(UIView *)view
{
    if (!self.superView && view)
    {
        self.superView = view;
        
        self.frame = view.bounds;
        [view addSubview:self];
        
        self.backgroundColor = view.backgroundColor;
        
        self.activityView.center = CGPointMake((CGRectGetWidth(self.bounds) / 2), (CGRectGetHeight(self.bounds) / 2));
        [self addSubview:self.activityView];
        self.activityView.hidden = YES;
        
        self.iconImageView.frame = CGRectMake(((CGRectGetWidth(self.bounds) - sizeImage) / 2), originYWithMessageAndButon, sizeImage, sizeImage);
        [self addSubview:self.iconImageView];
        self.iconImageView.hidden = YES;
        
        UIView *currentView = self.iconImageView;
        
        self.messagelabel.frame = CGRectMake(originXY, (currentView.frame.origin.y + currentView.frame.size.height + originXY), (CGRectGetWidth(self.bounds) - originXY * 2), heightlabel);
        [self addSubview:self.messagelabel];
        self.messagelabel.hidden = YES;
    
        currentView = self.messagelabel;
        
        self.reStartButton.frame = CGRectMake(((CGRectGetWidth(self.bounds) - widthButton) / 2), (currentView.frame.origin.y + currentView.frame.size.height + originXY), widthButton, heightButton);
        [self addSubview:self.reStartButton];
        self.reStartButton.hidden = YES;
    }
}

- (void)resetUI
{
    if (!self.superview)
    {
        [self.superView addSubview:self];
    }
    
    self.activityView.hidden = YES;
    self.iconImageView.hidden = YES;
    self.messagelabel.hidden = YES;
    self.reStartButton.hidden = YES;
}

- (void)setStatusUI:(NSString *)message image:(UIImage *)image
{
    [self resetUI];
    
    self.iconImageView.image = image;
    self.messagelabel.text = message;
    
    self.iconImageView.hidden = NO;
    CGRect rectImage = self.iconImageView.frame;
    rectImage.origin.y = originyWithMessage;

    self.messagelabel.hidden = NO;
    CGRect rectlabel = self.messagelabel.frame;
    rectlabel.origin.y = (originyWithMessage + self.iconImageView.frame.size.height + originXY);

    if (!message || 0 == message.length)
    {
        rectImage.origin.y = originY;

        rectlabel.origin.y = (originyWithMessage + self.iconImageView.frame.size.height + originXY);
        rectlabel.size.height = 0.0;
        self.messagelabel.hidden = YES;
    }
    
    self.iconImageView.frame = rectImage;
    
    self.messagelabel.frame = rectlabel;
}

- (void)statusloadedFinish
{
    if (self.isActivity)
    {
        if ([self.activityView isAnimating])
        {
            [self.activityView stopAnimating];
        }
    }
    
    if (self.superview)
    {
        [self removeFromSuperview];
    }
}

#pragma mark - 网络状态

// 开始（菊花转）
- (void)statusloadStart
{
    [self resetUI];
    
    self.isActivity = YES;
    
    self.activityView.color = [UIColor redColor];
    [self.activityView startAnimating];
    self.activityView.hidden = NO;
}

// 开始（自定义）
- (void)statusloadStartCustom:(NSString *)message image:(UIImage *)image
{
    self.message = message;
    self.image = image;
    
    [self setStatusUI:message image:image];
}

// 结束，加载成功
- (void)statusloadSueccess
{
    [self statusloadedFinish];
}

// 结束，加载成功，无数据
- (void)statusloadSuccessWithoutData:(NSString *)message image:(UIImage *)image
{
    [self setStatusUI:message image:image];
}

// 结束，加载失败
- (void)statusloadFailue:(NSString *)message image:(UIImage *)image
{
    [self setStatusUI:message image:image];
}

// 结束，加载失败（重新加载）
- (void)statusloadFailueAndRestart:(NSString *)message image:(UIImage *)image
{
    [self resetUI];
    
    self.iconImageView.image = image;
    self.messagelabel.text = message;
    
    self.iconImageView.hidden = NO;
    CGRect rectImage = self.iconImageView.frame;
    rectImage.origin.y = originYWithMessageAndButon;

    self.messagelabel.hidden = NO;
    CGRect rectlabel = self.messagelabel.frame;
    rectlabel.origin.y = (originYWithMessageAndButon + self.iconImageView.frame.size.height + originXY);

    if (!message || 0 == message.length)
    {
        rectImage.origin.y = originyWithButton;
        
        rectlabel.origin.y = (originyWithButton + self.iconImageView.frame.size.height + originXY);
        rectlabel.size.height = 0.0;
        self.messagelabel.hidden = YES;
    }
    
    self.iconImageView.frame = rectImage;

    self.messagelabel.frame = rectlabel;

    self.reStartButton.hidden = NO;
    CGRect rectButton = self.reStartButton.frame;
    rectButton.origin.y = (self.messagelabel.frame.origin.y + self.messagelabel.frame.size.height + originXY);
    self.reStartButton.frame = rectButton;
    [self.reStartButton addTarget:self action:@selector(buttonRestart:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 响应

- (void)buttonRestart:(UIButton *)button
{
    if (self.isActivity)
    {
        [self statusloadStart];
    }
    else
    {
        [self statusloadStartCustom:self.message image:self.image];
    }
    
    if (self.buttonClick)
    {
        self.buttonClick();
    }
}

#pragma mark - setter

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView)
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.backgroundColor = [UIColor clearColor];
    }
    
    return _activityView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    
    return _iconImageView;
}

- (UILabel *)messagelabel
{
    if (!_messagelabel)
    {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.backgroundColor = [UIColor clearColor];
        _messagelabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _messagelabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _messagelabel;
}

- (UIButton *)reStartButton
{
    if (!_reStartButton)
    {
        _reStartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reStartButton.backgroundColor = [UIColor clearColor];
        
        _reStartButton.layer.cornerRadius = 5.0;
        _reStartButton.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
        _reStartButton.layer.borderWidth = 0.5;
        
        [_reStartButton setTitle:@"重新加载" forState:UIControlStateNormal];
        _reStartButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_reStartButton setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.5] forState:UIControlStateNormal];
        [_reStartButton setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.2] forState:UIControlStateHighlighted];
    }
    
    return _reStartButton;
}

@end
