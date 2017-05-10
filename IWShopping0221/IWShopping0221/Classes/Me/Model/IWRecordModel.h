//
//  IWRecordModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/6.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWRecordModel : NSObject
// 店名
@property (nonatomic,copy)NSString *storeName;
// 图片
@property (nonatomic,copy)NSString *topImg;
// 订单号
@property (nonatomic,copy)NSString *order;
@property (nonatomic,copy)NSString *orderNum;
// time
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *orderTime;
// 支付
@property (nonatomic,copy)NSString *pay;
@property (nonatomic,copy)NSString *payNum;
// 支付方式
@property (nonatomic,copy)NSString *way;
@property (nonatomic,copy)NSString *payWay;
// integral
@property (nonatomic,copy)NSString *integral;
// orderId
@property (nonatomic,copy)NSString *orderId;
// updatedTime
@property (nonatomic,copy)NSString *updatedTime;

// Frame
// 店名
@property (nonatomic,assign,readonly)CGRect storeNameF;
// 图片
@property (nonatomic,assign,readonly)CGRect topImgF;
// 订单号
@property (nonatomic,assign,readonly)CGRect orderF;
@property (nonatomic,assign,readonly)CGRect orderNumF;
// 下单时间
@property (nonatomic,assign,readonly)CGRect timeF;
@property (nonatomic,assign,readonly)CGRect orderTimeF;
// 支付
@property (nonatomic,assign,readonly)CGRect payF;
@property (nonatomic,assign,readonly)CGRect payNumF;
// 支付方式
@property (nonatomic,assign,readonly)CGRect wayF;
@property (nonatomic,assign,readonly)CGRect payWayF;

// 线条一
@property (nonatomic,assign,readonly)CGRect linOneF;
// 线条二
@property (nonatomic,assign,readonly)CGRect linTwoF;

// cellH
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
