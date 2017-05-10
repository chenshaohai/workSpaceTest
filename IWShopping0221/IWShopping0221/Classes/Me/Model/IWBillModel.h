//
//  IWBillModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWBillModel : NSObject
// 时间
@property (nonatomic,copy)NSString *time;
// 交易类型
@property (nonatomic,copy)NSString *type;
// 收支
@property (nonatomic,copy)NSString *payNum;
// 操作
@property (nonatomic,copy)NSString *content;
// balanceId
@property (nonatomic,copy)NSString *balanceId;
// state
@property (nonatomic,copy)NSString *state;
// 查看详情
@property (nonatomic,copy)NSString *details;

- (id)initWithDic:(NSDictionary *)dic;
@end
