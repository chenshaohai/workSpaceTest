//
//  IWDingDanOneModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDingDanOneModel : NSObject
// 订单信息
@property (nonatomic,copy)NSString *orderContent;
// 订单编号
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)NSString *orderNum;
// 创建时间
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *createTime;
// 订单状态
@property (nonatomic,copy)NSString *state;
@property (nonatomic,copy)NSString *orderState;

/*
 *    Frame
 */
@property (nonatomic,assign,readonly)CGRect orderContentF;
// 订单编号
@property (nonatomic,assign,readonly)CGRect numF;
@property (nonatomic,assign,readonly)CGRect orderNumF;
// 创建时间
@property (nonatomic,assign,readonly)CGRect timeF;
@property (nonatomic,assign,readonly)CGRect createTimeF;
// 订单状态
@property (nonatomic,assign,readonly)CGRect stateF;
@property (nonatomic,assign,readonly)CGRect orderStateF;
// 表头
@property (nonatomic,assign,readonly)CGRect tableOneF;
// 分割线
@property (nonatomic,assign,readonly)CGRect linOneF;
// cellH
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
