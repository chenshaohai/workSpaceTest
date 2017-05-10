//
//  IWRegisterModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/5.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWRegisterModel : NSObject
// birthday
@property (nonatomic,copy)NSString *birthday;
// createdTime
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
// state
@property (nonatomic,copy)NSString *state;
// userAccount
@property (nonatomic,copy)NSString *userAccount;
// updatedTime
@property (nonatomic,copy)NSString *updatedTime;
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

- (id)initWithDic:(NSDictionary *)dic;

@end
