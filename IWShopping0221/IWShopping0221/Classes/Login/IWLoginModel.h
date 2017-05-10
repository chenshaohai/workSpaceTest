//
//  IWLoginModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWLoginModel : NSObject
@property (nonatomic,copy)NSString *birthday;
// 时间戳
@property (nonatomic,copy)NSString *createdTime;
// email
@property (nonatomic,copy)NSString *email;
// isRemind
@property (nonatomic,copy)NSString *isRemind;
// nickName
@property (nonatomic,copy)NSString *nickName;
// parentId
@property (nonatomic,copy)NSString *parentId;
// payQrCode
@property (nonatomic,copy)NSString *payQrCode;
// phone
@property (nonatomic,copy)NSString *phone;
// qrCode
@property (nonatomic,copy)NSString *qrCode;
// region
@property (nonatomic,copy)NSString *region;
// sex
@property (nonatomic,copy)NSString *sex;
// shopId
@property (nonatomic,copy)NSString *shopId;
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
// state
@property (nonatomic,copy)NSString *state;
// updatedTime
@property (nonatomic,copy)NSString *updatedTime;
// userAccount
@property (nonatomic,copy)NSString *userAccount;
// 密码
@property (nonatomic,copy)NSString *passwd;
// userBalance
@property (nonatomic,copy)NSString *userBalance;
// userId
@property (nonatomic,copy)NSString *userId;
// userImg
@property (nonatomic,copy)NSString *userImg;
// userIntegral
@property (nonatomic,copy)NSString *userIntegral;
// userName
@property (nonatomic,copy)NSString *userName;
// 余额url
@property (nonatomic,copy)NSString *balanceUrl;
@property (nonatomic,copy)NSString *integralUrl;
@property (nonatomic,copy)NSString *totalCommission;

- (id)initWithDic:(NSDictionary *)dic;

@end
