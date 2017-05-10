//
//  IWBillModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWBillModel.h"

@implementation IWBillModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // dic[@""]?dic[@""]:@"";
        self.time = dic[@"createdTime"]?dic[@"createdTime"]:@"";
        self.type = dic[@"type"]?dic[@"type"]:@"";
        self.payNum = dic[@"balance"]?dic[@"balance"]:@"";
        self.content = dic[@"description"]?dic[@"description"]:@"";
        self.balanceId = dic[@"balanceId"]?dic[@"balanceId"]:@"";
        self.state = dic[@"state"]?dic[@"state"]:@"";
        self.details = @"查看详情";
    }
    return self;
}
@end
