//
//  IWDetailSkuInfosModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailSkuInfosModel.h"

@implementation IWDetailSkuInfosModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _attValArr = dic[@"attValArr"]?dic[@"attValArr"]:@"";
        _attributeValueId = dic[@"attributeValueId"]?dic[@"attributeValueId"]:@"";
        _attributeValueName = dic[@"attributeValueName"]?dic[@"attributeValueName"]:@"";
        _itemId = dic[@"itemId"]?dic[@"itemId"]:@"";
        _salePrice = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        _stock = dic[@"stock"]?dic[@"stock"]:@"";
        
    }
    return self;
}

@end
