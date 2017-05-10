//
//  IWDingDanFourModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDingDanFourModel : NSObject
// 订单金额
@property (nonatomic,copy)NSString *orderSum;
// 订单总金额
@property (nonatomic,copy)NSString *total;
@property (nonatomic,copy)NSString *orderTotal;
// 订单运费
@property (nonatomic,copy)NSString *yunFei;
@property (nonatomic,copy)NSString *freight;
// 会币抵扣
@property (nonatomic,copy)NSString *zheKou;
@property (nonatomic,copy)NSString *discount;


@property (nonatomic,assign,readonly)CGRect orderSumF;
// 订单总金额
@property (nonatomic,assign,readonly)CGRect totalF;
@property (nonatomic,assign,readonly)CGRect orderTotalF;
// 订单运费
@property (nonatomic,assign,readonly)CGRect yuFeiF;
@property (nonatomic,assign,readonly)CGRect freightF;
// 会币抵扣
@property (nonatomic,assign,readonly)CGRect zheKouF;
@property (nonatomic,assign,readonly)CGRect discountF;

@property (nonatomic,assign,readonly)CGRect tableFourF;
@property (nonatomic,assign,readonly)CGRect linFourF;

// cellH
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
