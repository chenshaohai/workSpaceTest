//
//  IWRegisterModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/5.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWRegisterModel.h"

@implementation IWRegisterModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.birthday = dic[@"birthday"]?dic[@"birthday"]:@"";
        self.createdTime = dic[@"createdTime"]?dic[@"createdTime"]:@"";
        self.email = dic[@"email"]?dic[@"email"]:@"";
        self.isRemind = dic[@"isRemind"]?dic[@"isRemind"]:@"";
        self.nickName = dic[@"nickName"]?dic[@"nickName"]:@"";
        self.parentId = dic[@"parentId"]?dic[@"parentId"]:@"";
        self.payQrCode = dic[@"payQrCode"]?dic[@"payQrCode"]:@"";
        self.phone = dic[@"phone"]?dic[@"phone"]:@"";
        self.qrCode = dic[@"qrCode"]?dic[@"qrCode"]:@"";
        self.region = dic[@"region"]?dic[@"region"]:@"";
        self.sex = dic[@"sex"]?dic[@"sex"]:@"";
        self.shopId = dic[@"shopId"]?dic[@"shopId"]:@"";
        self.state = dic[@"state"]?dic[@"state"]:@"";
        self.updatedTime = dic[@"updatedTime"]?dic[@"updatedTime"]:@"";
        self.userAccount = dic[@"userAccount"]?dic[@"userAccount"]:@"";
        self.userBalance = dic[@"userBalance"]?dic[@"userBalance"]:@"";
        self.userId = dic[@"userId"]?dic[@"userId"]:@"";
        self.userImg = dic[@"userImg"]?dic[@"userImg"]:@"";
        self.userIntegral = dic[@"userIntegral"]?dic[@"userIntegral"]:@"";
        self.userName = dic[@"userName"]?dic[@"userName"]:@"";
    }
    return self;
}
@end
