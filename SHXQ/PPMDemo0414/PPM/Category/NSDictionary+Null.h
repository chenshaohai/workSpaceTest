//
//  NSDictionary+Null.h
//  E-Platform
//
//  Created by Apple on 2017/3/16.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Null)

/**
 获取类型安全字符串
 
 主要解析后台数据时用，将nil，null，<null>,非string类型转为空字符串
 后续如有其它情况，再另行添加

 @param key 字典key值
 @return 类型安全字符串
 */
- (NSString *)getSafeStringWithKey:(NSString *)key;
@end
