//
//  IWLuckyModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/4/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWLuckyModel : NSObject
// 礼物
@property (nonatomic,copy)NSString *gift;
// 结果
@property (nonatomic,copy)NSString *result;
// 行数
@property (nonatomic,copy)NSString *rownum;
// type
@property (nonatomic,copy)NSString *type;
// 赢得概率
@property (nonatomic,copy)NSString *winningConfig;

- (id)initWithDic:(NSDictionary *)dic;
@end
