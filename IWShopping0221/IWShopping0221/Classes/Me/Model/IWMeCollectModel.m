//
//  IWMeCollectModel.m
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeCollectModel.h"

@implementation IWMeCollectModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        /* {
         collectId = 2;
         integral = 0;
         productId = 2;
         productName = "Apple iPhone 5s  \U79fb\U52a8\U8054\U901a4G\U624b\U673a\U56fd\U884c\U7cbe\U54c1";
         salePrice = 55;
         smarketPrice = 99;
         thumbImg = "6fe1a863-571f-41d6-9d59-869bf26842dc";
         }
         */
        self.collectId = dic[@"collectId"]?dic[@"collectId"]:@"";
        self.productId = dic[@"productId"]?dic[@"productId"]:@"";
        self.img = dic[@"thumbImg"]?dic[@"thumbImg"]:@"";
        self.name = dic[@"productName"]?dic[@"productName"]:@"";
        self.price = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        self.allPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"";
        self.stock = dic[@"integral"]?dic[@"integral"]:@"0";
    }
    return self;
}
@end
