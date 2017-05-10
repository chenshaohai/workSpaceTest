//
//  PPMProgressModel.m
//  PPM
//
//  Created by lu_ios on 17/4/14.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import "PPMProgressModel.h"

@implementation PPMProgressModel
+(id)modelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _startDay = dic[@"startDay"]?dic[@"startDay"]:@"";
        _endDay = dic[@"endDay"]?dic[@"endDay"]:@"";
        _title = dic[@"title"]?dic[@"title"]:@"";
        
        
        NSString *type = dic[@"progressType"]?dic[@"progressType"]:@"";
        if ([type isEqual:@"plan"]) {
            _progressType = PPMProgressPlan;
        }else{
            _progressType = PPMProgressExecute;
        }
        NSString *total = dic[@"totalDay"]?dic[@"totalDay"]:@"0";
        _totalDay = [total integerValue];
    }
    return self;
}


@end
