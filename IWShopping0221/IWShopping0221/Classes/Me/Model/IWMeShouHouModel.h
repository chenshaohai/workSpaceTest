//
//  IWMeShouHouModel.h
//  IWShopping0221
//
//  Created by s on 17/3/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWMeShouHouModel : NSObject
/**
 *
 */
@property (nonatomic,copy)NSString *refundId;//

/**
 *
 */
@property (nonatomic,copy)NSString *shopId;//
/**
 *
 */
@property (nonatomic,copy)NSString *productName;//
/**
 *
 */
@property (nonatomic,copy)NSString *salePrice;//
/**
 *
 */
@property (nonatomic,copy)NSString *thumbImg;//
/**
 *  售后的中的个数
 */
@property (nonatomic,copy)NSString *refundCount;//

/**
 *     钱数
 */
@property (nonatomic,copy)NSString *refundMoney;//
/**
 *   规格
 */
@property (nonatomic,copy)NSString *attributeValue;//
/**
 *    原因
 */
@property (nonatomic,copy)NSString *refundReason;//
/**
 *     refundType退换类型（1表示只退款，2表示只退货，3表示退款并退货，4表示换货）
 */
@property (nonatomic,copy)NSString *refundType;//
/**
 *    商店名称
 */
@property (nonatomic,copy)NSString *shopName;

/**
 *
 */
@property (nonatomic,copy)NSString *smarketPrice;
/**
 *     state退换状态，0表示待审核，1表示退换中，2表示退换完成，-1表示退换取消
 */
@property (nonatomic,copy)NSString *state;

+ (id)modelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;
/*
 //attributeValue = "";//
 productName = "2017\U65b0\U6b3e\U76ae\U5939\U514b\U7537\U88c5\U6625\U5b63";//
 refundCount = 1; //
 refundId = 110;//
 refundMoney = 0;//
 refundReason = Thug; //
 refundType = 2;//
 salePrice = 159;//
 shopId = 16;//
 shopName = "\U6021\U666f\U9ea6\U5f53\U52b3\U5206\U5e97";//
 smarketPrice = 499;
 state = "-1";
 thumbImg = "/aigou/shop/20170312/e0bafff0-e8f3-4000-8290-05f91b29d503.jpg";//
 */
@end
