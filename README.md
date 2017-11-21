# NetworkStatusView
网络状态背景视图

网络状态，分以下几种情况
* 开始网络请求
  * 菊花转提示
  * 自定义图标、提示语
* 结束网络请求，成功
  * 自定义图标、提示语
  * 自定义图标、提示语、重新开始
* 结束网络请求，失败
  * 自定义图标、提示语
  * 自定义图标、提示语、重新开始


效果图

![image](./image.gif)

使用说明
~~~ javascript
// 导入头文件
#import "UIView+Status.h"
~~~ 

~~~ javascript
// 属性设置
// 是否全屏范围可点击
self.view.statusButtonFullScreen = NO;

// 多图时动画时间
self.view.statusAnimationTime = 1.2;

// 重置位置大小
self.view.statusView.frame = CGRectMake(0.0, 0.0, 200.0, 200.0);

// 提示标签属性设置
self.view.statusMessageLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
self.view.statusMessageLabel.textColor = [UIColor blueColor];

// 重新刷新按钮属性设置
[self.view.statusButton setTitle:@"reload" forState:UIControlStateNormal];
self.view.statusButton.layer.borderColor = [UIColor redColor].CGColor;
self.view.statusButton.frame = CGRectMake(0.0, 0.0, 200.0, 30.0);

// 对齐方式
self.view.statusViewAlignment = StatusViewAlignmentBottom;
~~~ 

~~~ javascript
// 默认菊花转请求
[self.view statusViewLoadStart];

// 自定义单图标、提示语请求
[self.view statusViewLoadStart:@"loading..." image:@[[UIImage imageNamed:@"status_Success"]]];

// 自定义多图标、提示语请求
[self.view statusViewLoadStart:@"loading..." image:@[[UIImage imageNamed:@"status_Success"], [UIImage imageNamed:@"status_failure"], [UIImage imageNamed:@"status_NetworkWrong"]]];
~~~ 

~~~ javascript
// 加载成功
[self.view statusViewLoadSuccess];

// 加载成功，没有数据时，自定义单图标、提示语
[self.view statusViewLoadSuccessWithoutData:@"没有数据" image:@[[UIImage imageNamed:@"lock_normal"]]];

// 加载成功，没有数据时，自定义多图标、提示语、重新请求
[self.view statusViewLoadSuccessWithoutData:@"没有数据" image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]] click:^{

}];
~~~ 

~~~ javascript
// 加载失败，自定义图标、提示语
[self.view statusViewLoadFailue:@"加载失败" image:@[[UIImage imageNamed:@"lock_normal"]]];

// 加载失败，自定义图标、提示语、重新请求
[self.view statusViewLoadFailue:@"加载失败" image:@[[UIImage imageNamed:@"lock_normal"], [UIImage imageNamed:@"lock_right"], [UIImage imageNamed:@"lock_wrong"]] click:^{

}];
~~~


## 修改完善
* 20171121
  * 版本号：1.2.0
  * 功能逻辑修改
    * 修改成UIView类扩展方法实现，便于所有UIView子类使用
    * 新增对齐属性：顶端对齐、居中对齐、底端对齐

* 20170915
  * 版本号：1.1.0
  * 新增重置位置大小方法

~~~ javascript
/// 重置视图位置与大小
- (void)reloadFrame:(CGRect)rect;
~~~

* 20170914
  * 版本号：1.0.0
  

