//
//  IWMeOrderFormShopModel.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/6.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeOrderFormProductModel.h"

@implementation IWMeOrderFormProductModel
+(id)modelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        
        /*
         {
         count = 2;
         orderDetailId = 1;
         productId = 1;
         productName = "\U8d1d\U8bd7\U60c5\U7ae5\U88c5\U513f\U7ae5\U7eaf\U68c9\U6625\U590f\U5b63\U7537\U5973\U7ae5\U5b9d\U5b9d\U7761\U8863\U5bb6\U5c45\U670d\U77ed\U8896\U5185\U8863\U79cb\U8863\U5957\U88c5   KT\U732b";
         salePrice = 34;
         thumbImg = "c0edc1ca-52f0-43b1-b7f4-8dc42d2aa447";
         }
         */
        _attributeValue = dic[@"attributeValue"]?dic[@"attributeValue"]:@"";

        _count = dic[@"count"]?dic[@"count"]:@"";
        _orderDetailId = dic[@"orderDetailId"]?dic[@"orderDetailId"]:@"";
        _productId = dic[@"productId"]?dic[@"productId"]:@"";
        _thumbImg = dic[@"thumbImg"]?dic[@"thumbImg"]:@"";
        _salePrice = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        _productName = dic[@"productName"]?dic[@"productName"]:@"";
        
        
        NSString  *smarketPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"0";
        
        _smarketPrice = [NSString stringWithFormat:@"%.2f",[smarketPrice floatValue]];
        
        _itemId = dic[@"itemId"]?dic[@"itemId"]:@"";
        
#warning 待测
        
        _integral = dic[@"integral"]?dic[@"integral"]:@"0";
        
    }
    return self;
}
@end
