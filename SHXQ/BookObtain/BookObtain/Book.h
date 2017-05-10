//
//  Book.h
//  BookObtain
//
//  Created by lu_ios on 2017/5/10.
//  Copyright © 2017年 lu_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
/**
 *   名字
 */
@property (nonatomic,copy)NSString *name;
/**
 *
 */
@property (nonatomic,copy)NSString *price;
/**
 *
 */
@property (nonatomic,copy)NSString *content;
- (id)initWithDic:(NSDictionary *)dic;
+ (id)bookWithDic:(NSDictionary *)dic;
@end
