//
//  IWReturnGoodsModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWReturnGoodsModel : NSObject
////attributeValue
//@property (nonatomic,copy)NSString *attributeValue;
////创建时间
//@property (nonatomic,copy)NSString *createdTime;
////itemId
//@property (nonatomic,copy)NSString *itemId;
////orderDetailId
//@property (nonatomic,copy)NSString *orderDetailId;
////orderId
//@property (nonatomic,copy)NSString *orderId;
////productId
//@property (nonatomic,copy)NSString *productId;
////productName
//@property (nonatomic,copy)NSString *productName;
////refundCount
//@property (nonatomic,copy)NSString *refundCount;
////refundId
//@property (nonatomic,copy)NSString *refundId;
////refundMoney
//@property (nonatomic,copy)NSString *refundMoney;
////refundNum
//@property (nonatomic,copy)NSString *refundNum;
////退回原因
//@property (nonatomic,copy)NSString *refundReason;
////refundType
//@property (nonatomic,copy)NSString *refundType;
////销售价格
//@property (nonatomic,copy)NSString *salePrice;
////shopId
//@property (nonatomic,copy)NSString *shopId;
////店铺名字
//@property (nonatomic,copy)NSString *shopName;
////市场价
//@property (nonatomic,copy)NSString *smarketPrice;
////状态
//@property (nonatomic,copy)NSString *state;
////头像
//@property (nonatomic,copy)NSString *thumbImg;
////更新时间
//@property (nonatomic,copy)NSString *updatedTime;


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
