# NetworkStatusView
网络状态背景视图

网络状态，即视图开始进行网络请求时，或是请求成功，请求失败等状态。
用户可根据需求进行自定义显示样式，包括是否设置图片，标题，以及失败时是否可以重新进行加载。

~~~ javascript

// 使用说明

#import "SYNetworkStatusView.h"

self.statusView = [[SYNetworkStatusView alloc] initWithView:self.view];

[self.statusView statusloadStart];

[self.statusView statusloadStartCustom:@"loading..." image:[UIImage imageNamed:@"lock_normal"]];

[self.statusView statusloadSuccessWithoutData:@"success" image:[UIImage imageNamed:@"lock_right"]];

[self.statusView statusloadFailue:@"failue" image:[UIImage imageNamed:@"lock_wrong"]];

[self.statusView statusloadFailueAndRestart:nil image:[UIImage imageNamed:@"lock_wrong"]];
self.statusView.buttonClick = ^(){
    NSLog(@"restart");
};

~~~