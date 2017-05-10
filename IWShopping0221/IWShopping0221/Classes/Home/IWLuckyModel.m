//
//  IWLuckyModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/4/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWLuckyModel.h"

@implementation IWLuckyModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _gift = dic[@"gift"]?:@"";
        _result = dic[@"result"]?:@"";
        _rownum = dic[@"rownum"]?:@"";
        _type = dic[@"type"]?:@"";
        _winningConfig = dic[@"winningConfig"]?:@"";
    }
    return self;
}
@end
