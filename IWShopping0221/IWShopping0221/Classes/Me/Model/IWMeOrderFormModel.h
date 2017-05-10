//
//  IWMeOrderFormModel.h
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWMeOrderFormModel : NSObject
/**
 *
 */
@property (nonatomic,copy)NSString *createdTime;
/**
 *
 */
@property (nonatomic,copy)NSString *expressNum;
/**
 *
 */
@property (nonatomic,copy)NSString *expressPrice;
/**
 *
 */
@property (nonatomic,copy)NSString *orderId;

/**
 *
 */
@property (nonatomic,copy)NSString *addressId;

/**
 *
 */
@property (nonatomic,strong)NSDictionary *addressInfo;

/*
 
 {
 addressId = 36;
 addressInfo = "";
 children =             (
 {
 attributeValue = "";
 count = 1;
 orderDetailId = 28;
 productId = 14;
 productName = "\U5e05\U6c14\U4f11\U95f2\U886c\U8863\U7537\U88c5";
 salePrice = 69;
 smarketPrice = 169;
 thumbImg = "/aigou/shop/20170312/53db2923-6413-474d-ac03-0d9f86a87add.jpg";
 }
 );
 createdTime = 1489514010000;
 expressNum = 755300189836;
 expressPrice = 0;
 orderId = 24;
 orderNum = 1489514010670;
 payPrice = 399;
 shopId = 14;
 shopName = "\U6fb3\U54c1\U835f";
 state = 1;
 updatedTime = 1489931125000;
 },
 
 */
/**
 * 商店名称
 */
@property (nonatomic,copy)NSString *shopName;
/**
 *
 */
@property (nonatomic,copy)NSString *orderNum;
/**
 *
 */
@property (nonatomic,copy)NSString *payPrice;
/**
 *
 */
@property (nonatomic,copy)NSString *state;
/**
 *
 */
@property (nonatomic,copy)NSString *updatedTime;
/**
 *
 */
@property (nonatomic,strong)NSArray *children;

/**
 *
 */
@property (nonatomic,copy)NSString *shopId;



+ (id)modelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;
@end
