//
//  IWDingDanTwoModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDingDanTwoModel.h"
// 名字固定宽度
#define kWidth kFRate(70)
// 左右间距
#define KWdis kFRate(10)
// 上下间距
#define kHdis kFRate(10)
@implementation IWDingDanTwoModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // 收货信息
        _consigneeMsg = @"收货信息";
        
        _name = @"收货人";
        _consigneeName = dic[@"consigneeName"]?dic[@"consigneeName"]:@"";
        
        _ph = @"电话号码";
        _phone = dic[@"phone"]?dic[@"phone"]:@"";
        
        _address = @"收货地址";
        _consigneeAdd = dic[@"consigneeAdd"]?dic[@"consigneeAdd"]:@"";
        
        [self frame];
    }
    return self;
}
- (void)frame{
    // 收货信息
    _tableTwoF = CGRectMake(0, 0, kViewWidth, kFRate(30));
    _consigneeMsgF = CGRectMake(KWdis, 0, kViewWidth - KWdis * 2, kFRate(30));
    _linTwoF = CGRectMake(KWdis, kFRate(30.5), kViewWidth - KWdis * 2, kFRate(0.5));
    
    CGSize nameSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_name];
    _nameF = CGRectMake(KWdis, CGRectGetMaxY(_linTwoF) + kHdis, kWidth, nameSize.height);
    CGSize consigneeNameSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kFont24px text:_consigneeName];
    _consigneeNameF = CGRectMake(CGRectGetMaxX(_nameF), CGRectGetMaxY(_linTwoF) + kHdis, consigneeNameSize.width, consigneeNameSize.height);
    
    CGSize phSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_ph];
    _phF = CGRectMake(KWdis, CGRectGetMaxY(_nameF) + kHdis, kWidth, phSize.height);
    CGSize phoneSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kFont24px text:_phone];
    _phoneF = CGRectMake(CGRectGetMaxX(_phF), CGRectGetMaxY(_nameF) + kHdis, phoneSize.width, phoneSize.height);
    
    CGSize addSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_address];
    _addF = CGRectMake(KWdis, CGRectGetMaxY(_phF) + kHdis, kWidth, addSize.height);
    CGSize consigneeAddSize = [self initWithWidth:kViewWidth - KWdis * 2 - kWidth height:MAXFLOAT font:kFont24px text:_consigneeAdd];
    _consigneeAddF = CGRectMake(CGRectGetMaxX(_addF), CGRectGetMaxY(_phF) + kHdis, kViewWidth - KWdis * 2 - kWidth, consigneeAddSize.height);
    
    if (CGRectGetMaxY(_addF) >= CGRectGetMaxY(_consigneeAddF)) {
        _cellH = CGRectGetMaxY(_addF) + kFRate(20);
    }else{
        _cellH = CGRectGetMaxY(_consigneeAddF) + kFRate(20);
    }
    
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}
@end
