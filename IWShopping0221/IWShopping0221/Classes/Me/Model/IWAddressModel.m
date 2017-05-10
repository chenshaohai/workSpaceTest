//
//  IWAddressModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/8.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWAddressModel.h"
#define kTextFont kFont32px
@implementation IWAddressModel
- (id)initWithDic:(NSDictionary *)dic
{
    // dic[@""]?dic[@""]:@"";
    self = [super init];
    if (self) {
        self.name = dic[@"consignee"]?dic[@"consignee"]:@"";
        self.phone = dic[@"phone"]?dic[@"phone"]:@"";
        // 省份
        self.province = dic[@"province"]?dic[@"province"]:@"";
        // city
        self.city = dic[@"city"]?dic[@"city"]:@"";
        // 区域
        self.district = dic[@"district"]?dic[@"district"]:@"";
        // 详细地址
        self.detailAddress = dic[@"detailAddress"]?dic[@"detailAddress"]:@"";
        // 邮编
        self.zipCode = dic[@"zipCode"]?dic[@"zipCode"]:@"";
        // 地址拼接
        self.address = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",self.province,self.city,self.district,self.detailAddress,self.zipCode];
        NSString *state = [NSString stringWithFormat:@"%@",dic[@"state"]?dic[@"state"]:@""];
        if ([state isEqual:@"1"]) {
            self.state = YES;
        }else{
            self.state = NO;
        }
        self.userId = dic[@"userId"]?dic[@"userId"]:@"";
        self.userName = dic[@"userName"]?dic[@"userName"]:@"";
        self.addressId = dic[@"addressId"]?dic[@"addressId"]:@"";
        
        [self frame];
    }
    return self;
}

- (void)frame{
    // name
    CGSize nameSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kTextFont text:_name];
    _nameF = CGRectMake(kFRate(10), kFRate(15), nameSize.width, nameSize.height);
    
    // 电话
    CGSize phoneSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kTextFont text:_phone];
    _phoneF = CGRectMake(CGRectGetMaxX(_nameF) + kFRate(15), kFRate(15), phoneSize.width, phoneSize.height);
    
    // 地址
    CGSize addSize = [self initWithWidth:kViewWidth - kFRate(20) height:MAXFLOAT font:kTextFont text:_address];
    _addressF = CGRectMake(kFRate(10), CGRectGetMaxY(_nameF) + kFRate(10), addSize.width, addSize.height);
    
    // 分割线
    _linF = CGRectMake(kFRate(10), CGRectGetMaxY(_addressF) + kFRate(10), kViewWidth - kFRate(20), kFRate(0.5));
    
    // 选择默认地址按钮
    _selectBtnF = CGRectMake(kFRate(10), CGRectGetMaxY(_linF), kFRate(100), kFRate(40));
    
    // 编辑按钮
    _editF = CGRectMake(kViewWidth - kFRate(10) - kFRate(120), CGRectGetMaxY(_linF), kFRate(60), kFRate(40));
    
    // 删除按钮
    _deleteF = CGRectMake(CGRectGetMaxX(_editF), CGRectGetMaxY(_linF), kFRate(60), kFRate(40));
    
    _cellH = CGRectGetMaxY(_deleteF) + kFRate(10);
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}

@end
