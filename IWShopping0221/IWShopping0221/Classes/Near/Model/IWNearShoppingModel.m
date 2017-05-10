//
//  APMProjectModel.m

//
//  Created by xiaohai on 16/11/7.
//  Copyright © 2016年  All rights reserved.
//

#import "IWNearShoppingModel.h"
@implementation IWNearShoppingModel
+(id)modelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        
       
        
        _modelId = dic[@"shopId"]?dic[@"shopId"]:@"";
        _name = dic[@"shopName"]?dic[@"shopName"]:@"";
#warning 测试
        NSString *score = dic[@"shopLevel"]?dic[@"shopLevel"]:@"0";
        if ([score isKindOfClass:[NSNull class]] || [score isEqual:@"NSNull"]) {
            _score = @"0";
        }else{
            _score = score;
        }
        
        NSLog(@"-------%@------",_score);
        
        _count = dic[@"count"]?dic[@"count"]:@"";
        _content = dic[@"shopSummary"]?dic[@"shopSummary"]:@"";
       NSString *logo = dic[@"shopLogo"]?dic[@"shopLogo"]:@"";
        if (logo && [logo isKindOfClass:[NSString class]] && logo.length > 0) {
            _logo = logo;
        }else{
        _logo = @"";
        }
        _distance = dic[@"juli"]?dic[@"juli"]:@"";
        _discount = dic[@"discountRatio"]?dic[@"discountRatio"]:@"";
        
        
        _businessCateId = dic[@"businessCateId"]?dic[@"businessCateId"]:@"";
        _ainitId = dic[@"initId"]?dic[@"initId"]:@"";
        _shopX = dic[@"shopX"]?dic[@"shopX"]:@"";
        _shopY = dic[@"shopY"]?dic[@"shopY"]:@"";
        
        
        _shopOfiiceTime = dic[@"shopOfiiceTime"]?dic[@"shopOfiiceTime"]:@"";
        _shopType = dic[@"shopType"]?dic[@"shopType"]:@"";
        _state = dic[@"state"]?dic[@"state"]:@"";
        
        
    }
    return self;
}

@end
