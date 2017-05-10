//
//  IWLoginModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWLoginModel.h"

@interface IWLoginModel ()<NSCoding,NSCopying>

@end

@implementation IWLoginModel


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _userId = dic[@"userId"]?dic[@"userId"]:@"";
        _birthday = dic[@"birthday"]?dic[@"birthday"]:@"";
        _createdTime = dic[@"createdTime"]?dic[@"createdTime"]:@"";
        _email = dic[@"email"]?dic[@"email"]:@"";
        _isRemind = dic[@"isRemind"]?dic[@"isRemind"]:@"";
        _nickName = dic[@"nickName"]?dic[@"nickName"]:@"";
        _parentId = dic[@"parentId"]?dic[@"parentId"]:@"";
        _balanceUrl = dic[@"balanceUrl"]?dic[@"balanceUrl"]:@"";
        _integralUrl = dic[@"integralUrl"]?dic[@"integralUrl"]:@"";
        /*balanceUrl = "http://www.weiyunshidai.com/wap/contactUs.html";
         birthday = "";
         createdTime = 1489127749000;
         email = "";
         integralUrl = "http://www.weiyunshidai.com/wap/contactUs.html";
         isRemind = 0;
         nickName = "";
         parentId = "-1";
         payQrCode = "";
         phone = 18565822821;
         qrCode = "";
         region = "";
         sex = 1;
         shopId = "-1";
         state = "";
         updatedTime = 1489127749000;
         userAccount = 18565822821;
         userBalance = 0;
         userId = 29;
         userImg = "http://wx.qlogo.cn/mmopen/kgGDic7qydL9JCOaN0rQqWGs2b5xIG73jVPuz3XbVTkTCWiarUqOtYFYBgC4bWh6nuWY0I32oSVBhXTVcsvl263Zib9pRHiauqPO/0";
         userIntegral = 0;
         userName = 18565822821;*/
        _payQrCode = dic[@"payQrCode"]?dic[@"payQrCode"]:@"";
        _phone = dic[@"phone"]?dic[@"phone"]:@"";
        _qrCode = dic[@"qrCode"]?dic[@"qrCode"]:@"";
        _region = dic[@"region"]?dic[@"region"]:@"";
        _sex = dic[@"sex"]?dic[@"sex"]:@"";
        _shopId = dic[@"shopId"]?dic[@"shopId"]:@"";
        _state = dic[@"state"]?dic[@"state"]:@"";
        _updatedTime = dic[@"updatedTime"]?dic[@"updatedTime"]:@"";
        _userAccount = dic[@"userAccount"]?dic[@"userAccount"]:@"";
        _passwd = dic[@"passwd"]?dic[@"passwd"]:@"";
        _userBalance = dic[@"userBalance"]?dic[@"userBalance"]:@"";
        _userImg = dic[@"userImg"]?dic[@"userImg"]:@"";
        _userIntegral = dic[@"userIntegral"]?dic[@"userIntegral"]:@"";
        _userName = dic[@"userName"]?dic[@"userName"]:@"";
        _totalCommission = dic[@"totalCommission"]?:@"";
    }
    return self;
}

//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_userId forKey:@"userId"];
//    [aCoder encodeObject:_birthday forKey:@"birthday"];
//    [aCoder encodeObject:_createdTime forKey:@"createdTime"];
//    [aCoder encodeObject:_email forKey:@"email"];
//    [aCoder encodeObject:_nickName forKey:@"nickName"];
//    [aCoder encodeObject:_parentId forKey:@"parentId"];
//    [aCoder encodeObject:_balanceUrl forKey:@"balanceUrl"];
//    [aCoder encodeObject:_integralUrl forKey:@"integralUrl"];
//    [aCoder encodeObject:_payQrCode forKey:@"payQrCode"];
//    [aCoder encodeObject:_phone forKey:@"phone"];
//    [aCoder encodeObject:_qrCode forKey:@"qrCode"];
//    [aCoder encodeObject:_region forKey:@"region"];
//    [aCoder encodeObject:_sex forKey:@"sex"];
//    [aCoder encodeObject:_shopId forKey:@"shopId"];
//    [aCoder encodeObject:_state forKey:@"state"];
//    [aCoder encodeObject:_updatedTime forKey:@"updatedTime"];
//    [aCoder encodeObject:_userAccount forKey:@"passwd "];
//    [aCoder encodeObject:_passwd forKey:@"userId"];
//    [aCoder encodeObject:_userBalance forKey:@"userBalance"];
//    [aCoder encodeObject:_userImg forKey:@"userImg"];
//    [aCoder encodeObject:_userIntegral forKey:@"userIntegral"];
//    [aCoder encodeObject:_userName  forKey:@"userName"];
//
//    
//}
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if (self) {
//        _userId = [aDecoder decodeObjectForKey:@"userId"];
//        _birthday = [aDecoder decodeObjectForKey:@"birthday"];
//        _createdTime = [aDecoder decodeObjectForKey:@"createdTime"];
//        _email = [aDecoder decodeObjectForKey:@"email"];
//        _nickName = [aDecoder decodeObjectForKey:@"nickName"];
//        _parentId = [aDecoder decodeObjectForKey:@"parentId"];
//        _balanceUrl = [aDecoder decodeObjectForKey:@"balanceUrl"];
//        _integralUrl = [aDecoder decodeObjectForKey:@"integralUrl"];
//        _payQrCode = [aDecoder decodeObjectForKey:@"payQrCode"];
//        _phone = [aDecoder decodeObjectForKey:@"phone"];
//        _qrCode = [aDecoder decodeObjectForKey:@"qrCode"];
//        _region = [aDecoder decodeObjectForKey:@"region"];
//        _sex = [aDecoder decodeObjectForKey:@"sex"];
//        _shopId = [aDecoder decodeObjectForKey:@"shopId"];
//        _state = [aDecoder decodeObjectForKey:@"state"];
//        _updatedTime = [aDecoder decodeObjectForKey:@"updatedTime"];
//        _userAccount = [aDecoder decodeObjectForKey:@"userAccount"];
//        _passwd = [aDecoder decodeObjectForKey:@"passwd"];
//        _userBalance = [aDecoder decodeObjectForKey:@"userBalance"];
//        _userImg = [aDecoder decodeObjectForKey:@"userImg"];
//        _userIntegral = [aDecoder decodeObjectForKey:@"userIntegral"];
//        _userName = [aDecoder decodeObjectForKey:@"userName"];
//        
//    }
//    return self;
//}
@end
