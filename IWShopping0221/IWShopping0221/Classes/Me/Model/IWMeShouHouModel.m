//
//  IWMeShouHouModel.m
//  IWShopping0221
//
//  Created by s on 17/3/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeShouHouModel.h"

@implementation IWMeShouHouModel
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
        _thumbImg = dic[@"thumbImg"]?dic[@"thumbImg"]:@"";
        _state = dic[@"state"]?dic[@"state"]:@"0";
        _smarketPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"0";
        _shopName = dic[@"shopName"]?dic[@"shopName"]:@"";
        _shopId = dic[@"shopId"]?dic[@"shopId"]:@"";
        _refundType = dic[@"refundType"]?dic[@"refundType"]:@"";
        _attributeValue = dic[@"attributeValue"]?dic[@"attributeValue"]:@"";
        _productName = dic[@"productName"]?dic[@"productName"]:@"";
        _refundCount = dic[@"refundCount"]?dic[@"refundCount"]:@"1";
        _refundId = dic[@"refundId"]?dic[@"refundId"]:@"";
        _refundMoney = dic[@"refundMoney"]?dic[@"refundMoney"]:@"0";
        _salePrice = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        _refundReason = dic[@"refundReason"]?dic[@"refundReason"]:@"";
        
    }
    return self;
}
@end
