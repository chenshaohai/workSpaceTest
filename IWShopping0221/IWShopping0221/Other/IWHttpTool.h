//
//  IWHttpTool.h
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  封装整个项目的GET\POST请求

#import <Foundation/Foundation.h>
typedef void(^IWHttpToolResponse) (id jsonData,BOOL success);

@interface IWHttpTool : NSObject

@property (nonatomic,copy)IWHttpToolResponse responseBody;


/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param jsonString  请求Json字符串
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postCreatOrderWithURL:(NSString *)url jsonString:(NSString *)jsonString success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
