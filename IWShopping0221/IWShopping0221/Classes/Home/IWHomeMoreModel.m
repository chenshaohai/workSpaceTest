//
//  IWHomeMoreModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeMoreModel.h"

@implementation IWHomeMoreModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.img = dic[@"originalImg"]?dic[@"originalImg"]:@"";
        self.name = dic[@"productName"]?dic[@"productName"]:@"";
        self.price = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        self.allPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"";
        self.stock = dic[@"saleCount"]?dic[@"saleCount"]:@"";
        self.productId = dic[@"productId"]?dic[@"productId"]:@"";
    }
    return self;
}
@end
