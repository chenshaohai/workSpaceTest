//
//  IWHomeNoticeModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeNoticeModel.h"

@implementation IWHomeNoticeModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.noticeDesc = dic[@"noticeDesc"]?dic[@"noticeDesc"]:@"";
        self.noticeId = dic[@"noticeId"]?dic[@"noticeId"]:@"";
    }
    return self;
}
@end
