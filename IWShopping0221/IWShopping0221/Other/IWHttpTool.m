//
//  IWHttpTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWHttpTool.h"
#import "AFNetworking.h"

@implementation IWHttpTool

+ (void)postCreatOrderWithURL:(NSString *)url jsonString:(NSString *)jsonString success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    NSString *body;
    if (jsonString) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonString options:NSJSONWritingPrettyPrinted error:nil];
        body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        body = @"{}";
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @try {
                if (error == nil) {
                    NSError *jError = nil;
                    id jData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jError];
                    if (jError == nil) {
                        if (success) {
                            NSDictionary *dict = [NSDictionary changeType:jData];
                            
                            success(dict);
                        }
                    }else{
                        if (failure) {
                            failure(jData);
                        }
                    }
                }else{
                    if (failure) {
                        failure(error);
                    }
                }
            }
            @catch (NSException *exception) {
                IWLog(@"%@",exception.reason);
            }
            @finally {
                
            }
        });
    }];
    [dataTask resume];
}



+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
        NSString *body;
        if (params) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
            body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        } else {
            body = @"{}";
        }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @try {
                if (error == nil) {
                    NSError *jError = nil;
                    id jData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jError];
                    if (jError == nil) {
                        if (success) {
                            NSDictionary *dict = [NSDictionary changeType:jData];
                            
                            success(dict);
                        }
                    }else{
                        if (failure) {
                            failure(jData);
                        }
                    }
                }else{
                    if (failure) {
                        failure(error);
                    }
                }
            }
            @catch (NSException *exception) {
                IWLog(@"%@",exception.reason);
            }
            @finally {
                
            }
        });
    }];
    [dataTask resume];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @try {
                if (error == nil) {
                    NSError *jError = nil;
                    id jData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jError];
                    if (jError == nil) {
                        if (success) {
                            NSDictionary *dict = [NSDictionary changeType:jData];
                            
                            success(dict);
                        }
                    }else{
                        if (failure) {
                            failure(jData);
                        }
                    }
                }else{
                    if (failure) {
                        failure(error);
                    }
                }
            }
            @catch (NSException *exception) {
                IWLog(@"%@",exception.reason);
            }
            @finally {
                
            }
        });
    }];
    [dataTask resume];
}
@end


