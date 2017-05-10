//
//  IWItemsModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/15.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWItemsModel.h"

@implementation IWItemsModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _attValArr = dic[@"attValArr"]?dic[@"attValArr"]:@"";
        _itemId = dic[@"itemId"]?dic[@"itemId"]:@"";
        _salePrice = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        _smarketPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"";
        _stock = dic[@"stock"]?dic[@"stock"]:@"0";
    }
    return self;
}
@end
