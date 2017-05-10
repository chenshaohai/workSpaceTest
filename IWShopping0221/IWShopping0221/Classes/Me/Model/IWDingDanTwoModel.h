//
//  IWDingDanTwoModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDingDanTwoModel : NSObject
// 收货信息
@property (nonatomic,copy)NSString *consigneeMsg;
// 收货人
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *consigneeName;
// 电话
@property (nonatomic,copy)NSString *ph;
@property (nonatomic,copy)NSString *phone;
// 收货地址
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *consigneeAdd;


@property (nonatomic,assign,readonly)CGRect consigneeMsgF;
// 收货人
@property (nonatomic,assign,readonly)CGRect nameF;
@property (nonatomic,assign,readonly)CGRect consigneeNameF;
// 电话
@property (nonatomic,assign,readonly)CGRect phF;
@property (nonatomic,assign,readonly)CGRect phoneF;
// 收货地址
@property (nonatomic,assign,readonly)CGRect addF;
@property (nonatomic,assign,readonly)CGRect consigneeAddF;

@property (nonatomic,assign,readonly)CGRect tableTwoF;
@property (nonatomic,assign,readonly)CGRect linTwoF;

// cellH
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
