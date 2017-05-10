//
//  ASingleton.m

//
//  Created by admin on 16/8/23.
//  Copyright © 2016年  All rights reserved.
//

#import "ASingleton.h"
#import "ALoadingView.h"
@implementation ASingleton
// 获取单例
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
#pragma mark Loading

// webservice开始
- (void)startLoadingInView:(UIView *)view
{
    //开始加载，加一，
    _loadingCount++;
    if (_loadingCount == 1) {
        _loadingView = [ALoadingView shareLoadingView];
        [_loadingView show];
    }
    //整个界面不响应点击事件
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    window.userInteractionEnabled = NO;
    // 网络加载标志停止转动
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// webservice结束
- (void)stopLoadingView
{
    if (_loadingCount > 0) {
        _loadingCount--;  //减一 清零
    }
    // 当没有请求web的时候才移除loading
    if (_loadingCount == 0) {
        [_loadingView close];
        _loadingView = nil;
        //整个界面响应点击事件
         UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        window.userInteractionEnabled = YES;
        // 网络加载标志停止转动
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

// webservice结束
- (void)mustStopLoadingView
{
    if (_loadingCount > 0) {
        [_loadingView close];
        _loadingView = nil;
        _loadingCount = 0;  //清零
    }
    //整个界面响应点击事件
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    window.userInteractionEnabled = YES;
    // 网络加载标志停止转动
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)setLatitude:(CGFloat)latitude{
    _latitude = latitude;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *value = [NSString stringWithFormat:@"%f",latitude];
    NSString *key=@"IWNearLatitude";
    [defaults setObject:value forKey:key];
}

-(void)setLongitude:(CGFloat)longitude{
    _longitude = longitude;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *value = [NSString stringWithFormat:@"%f",longitude];
    NSString *key=@"IWNearLongitude";
    [defaults setObject:value forKey:key];
}

-(void)setCity:(NSString *)city{
    _city = city;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *value = city;
    NSString *key=@"IWNearCity";
    [defaults setObject:value forKey:key];
}


@end
