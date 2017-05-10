//
//  IWShoppingModel.h
//  IWShopping0221
//
//  Created by s on 17/2/21.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWShoppingModel : NSObject
/**
 *
 */
@property (nonatomic,copy)NSString *shopId;
/**
 *
 */
@property (nonatomic,copy)NSString *shopName;
/**
 *
 */
@property (nonatomic,copy)NSString *itemId;
/**
 *
 */
@property (nonatomic,copy)NSString *cartId;

/**
 *   ID
 */
@property (nonatomic,copy)NSString *modelId;
/**
 *   名字
 */
@property (nonatomic,copy)NSString *name;
/**
 *
 */
@property (nonatomic,copy)NSString *count;
/**
 *
 */
@property (nonatomic,copy)NSString *userId;
/**
 * 贝壳数量
 */
@property (nonatomic,copy)NSString *integral;


/**
 * 运费
 */
@property (nonatomic,copy)NSString *expressMoney;
/*
 
 {
 attributeValue = "\U89c4\U683c:";
 cartId = 27;
 count = 1;
 expressMoney = 20;
 integral = 0;
 itemId = 96;
 productId = 9;
 productName = "\U6c90\U79cb\U6625\U5b63\U5f39\U529b\U68c9\U8d28\U8fde\U5e3d\U5e26\U5957\U5934\U7537\U536b\U8863\U6f6e\U724c\U97e9\U7248\U5b66\U751f\U5bbd\U677e\U5927\U7801\U8fd0\U52a8\U5916\U5957";
 salePrice = "0.01";
 shopId = 6;
 smarketPrice = 298;
 thumbImg = "/aigou/shop/20170417/28ef1733-4b35-406d-aa08-6d0145b629fb.jpg";
 userId = 118;
 }
 
 */
/**
 *
 */
@property (nonatomic,copy)NSString *content;
/**
 *  图标
 */
@property (nonatomic,copy)NSString *logo;
/**
 * 实际销售价
 */
@property (nonatomic,copy)NSString *price;
/**
 * 市场价
 */
@property (nonatomic,copy)NSString *smarketPrice;

/**
 * 是否选中
 */
@property (nonatomic,assign)BOOL haveSelect;
/**
 * 整个数组是否选中                     组模型
 */
@property (nonatomic,assign)BOOL haveSectionSelect;
/**
 * 确认订单页面的   留言               组模型
 */
@property (nonatomic,copy)NSString *liuYan;
/**
 * 确认订单页面的  商店 总价            组模型
 */
@property (nonatomic,copy)NSString *totalPrice;
/**
 * 确认订单页面的   商店 实际总价       组模型
 */
@property (nonatomic,copy)NSString *payPrice;


+ (id)modelWithDic:(NSDictionary *)dic shopId:(NSString *)shopId shopName:(NSString *)shopName;
- (id)initWithDic:(NSDictionary *)dic shopId:(NSString *)shopId shopName:(NSString *)shopName;
@end
