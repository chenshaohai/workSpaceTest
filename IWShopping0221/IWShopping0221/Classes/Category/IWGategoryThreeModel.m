//
//  IWGategoryThreeModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/2.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGategoryThreeModel.h"

@implementation IWGategoryThreeModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.cateIconImg = dic[@"cateIconImg"]?dic[@"cateIconImg"]:@"";
        self.cateId = dic[@"cateId"]?dic[@"cateId"]:@"";
        self.cateName = dic[@"cateName"]?dic[@"cateName"]:@"";
    }
    return self;
}
@end
