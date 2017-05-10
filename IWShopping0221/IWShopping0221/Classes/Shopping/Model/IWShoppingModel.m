//
//  IWShoppingModel.m
//  IWShopping0221
//
//  Created by s on 17/2/21.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWShoppingModel.h"

@implementation IWShoppingModel
+(id)modelWithDic:(NSDictionary *)dic shopId:(NSString *)shopId shopName:(NSString *)shopName
{
    return [[self alloc]initWithDic:dic shopId:shopId shopName:shopName];
}
-(id)initWithDic:(NSDictionary *)dic shopId:(NSString *)shopId shopName:(NSString *)shopName
{
    self = [super init];
    if (self)
    {
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
        _modelId = dic[@"productId"]?dic[@"productId"]:@"";
        _name = dic[@"productName"]?dic[@"productName"]:@"";
        _price = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        
        _expressMoney =  dic[@"expressMoney"]?dic[@"expressMoney"]:@"0";
        _count = dic[@"count"]?dic[@"count"]:@"";
        _content = dic[@"attributeValue"]?dic[@"attributeValue"]:@"";
        _logo = dic[@"thumbImg"]?dic[@"thumbImg"]:@"";
        _cartId = dic[@"cartId"]?dic[@"cartId"]:@"";
        _itemId = dic[@"itemId"]?dic[@"itemId"]:@"";
        _userId = dic[@"userId"]?dic[@"userId"]:@"";
        _integral = dic[@"integral"]?dic[@"integral"]:@"0";
        _shopId = shopId;
        _shopName = shopName;
        _smarketPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"";
        _liuYan = @"";
        _totalPrice = @"";
        _payPrice = @"";
    }
    return self;
}

@end
