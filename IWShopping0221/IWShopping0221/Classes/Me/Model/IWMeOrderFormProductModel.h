//
//  IWMeOrderFormShopModel.h
//  IWShopping0221
//
//  Created by FRadmin on 17/3/6.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWMeOrderFormProductModel : NSObject

/**
 *
 */
@property (nonatomic,copy)NSString *orderDetailId;

/**
 *
 */
@property (nonatomic,copy)NSString *productId;
/**
 *
 */
@property (nonatomic,copy)NSString *productName;
/**
 *
 */
@property (nonatomic,copy)NSString *salePrice;
/**
 *
 */
@property (nonatomic,copy)NSString *thumbImg;
/**
 *   ID
 */
@property (nonatomic,copy)NSString *count;

/**
 *   售后的中的个数
 */
@property (nonatomic,copy)NSString *countShouHou;
/**
 *   规格
 */
@property (nonatomic,copy)NSString *attributeValue;
/**
 *
 */
@property (nonatomic,copy)NSString *smarketPrice;
/**
 *
 */
@property (nonatomic,copy)NSString *itemId;
/*
 attributeValue = "";
 count = 1;
 orderDetailId = 28;
 productId = 14;
 productName = "\U5e05\U6c14\U4f11\U95f2\U886c\U8863\U7537\U88c5";
 salePrice = 69;
 smarketPrice = 169;
 thumbImg = "/aigou/shop/20170312/53db2923-6413-474d-ac03-0d9f86a87add.jpg";
 }
*/

/**
 * 贝壳数量
 */
@property (nonatomic,copy)NSString *integral;

+ (id)modelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;
@end
