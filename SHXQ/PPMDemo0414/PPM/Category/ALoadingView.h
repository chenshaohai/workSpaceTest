//
//  ALoadingView.h
//  自定义加载中
//
//  Created by FRadmin on 16/7/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AActivityIndicicator.h"

@interface ALoadingView : UIView
{
    ///指示器
    AActivityIndicicator *indicatorView;
    ///包含指示器和文字的view
    UIView *conerView;
}
///是否是模拟同步
@property (nonatomic) BOOL isLikeSynchro;

@property (nonatomic,copy)NSString *loadStr;

///显示加载框
- (void)show;
//给文字，显示加载框,
- (void)showWithTitle:(NSString *)title;

- (void)loadingShow;

///关闭加载框
- (void)close;

///获取LoadingView单例,isLikeSynchro  Yes:类似同步，通过遮盖整个窗体实现 No:异步
+ (ALoadingView *)shareLoadingView;
@end
