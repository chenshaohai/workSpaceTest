//
//  IWAddressModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/8.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWAddressModel : NSObject
// 名字 consignee
@property (nonatomic,copy)NSString *name;
// 电话
@property (nonatomic,copy)NSString *phone;
// 地址
@property (nonatomic,copy)NSString *address;
// 地址选择状态
@property (nonatomic,assign)BOOL state;
// addressId
@property (nonatomic,copy)NSString * addressId;
// city
@property (nonatomic,copy)NSString * city;
// detailAddress 详细地址
@property (nonatomic,copy)NSString * detailAddress;
// district 区域
@property (nonatomic,copy)NSString * district;
// province 省份
@property (nonatomic,copy)NSString * province;
// userId
@property (nonatomic,copy)NSString * userId;
// userName
@property (nonatomic,copy)NSString * userName;
// zipCode 邮编
@property (nonatomic,copy)NSString * zipCode;


// Frame
@property (nonatomic,assign,readonly)CGRect nameF;
@property (nonatomic,assign,readonly)CGRect phoneF;
@property (nonatomic,assign,readonly)CGRect addressF;
// 分割线
@property (nonatomic,assign,readonly)CGRect linF;
// 选择地址按钮
@property (nonatomic,assign,readonly)CGRect selectBtnF;
// 编辑
@property (nonatomic,assign,readonly)CGRect editF;
// 删除
@property (nonatomic,assign,readonly)CGRect deleteF;
// cell高度
@property (nonatomic,assign)CGFloat cellH;

- (id)initWithDic:(NSDictionary *)dic;
@end
