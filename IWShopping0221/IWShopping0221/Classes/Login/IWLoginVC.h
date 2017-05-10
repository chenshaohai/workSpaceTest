//
//  IWLoginVC.h
//  IWShopping0221
//
//  Created by admin on 2017/2/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWLoginVC : UIViewController
#pragma mark - 登录请求,用于修改个人数据后 刷新数据
+(void)loginWithUserAcount:(NSString *)acount passWord:(NSString *)passWord success:(void (^)(NSString *))success failure:(void (^)(NSString *))failure;
@end
