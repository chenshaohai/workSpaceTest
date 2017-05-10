//
//  IWRecordModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/6.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWRecordModel.h"

@implementation IWRecordModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // dic[@""]?dic[@""]:@""
        self.storeName = dic[@"shopName"]?dic[@"shopName"]:@"";
        self.topImg = dic[@"shopLogo"]?dic[@"shopLogo"]:@"";
        self.order = @"订单号：";
        self.orderNum = dic[@"orderNum"]?dic[@"orderNum"]:@"";
        self.time = @"下单时间：";
        self.orderTime = [NSDate dateToyyyyMMddHHmmssStringWithInteger:[dic[@"createdTime"]?dic[@"createdTime"]:@"" doubleValue]];
        self.pay = @"支付：";
        self.payNum = dic[@"payPrice"]?dic[@"payPrice"]:@"";
        self.way = @"支付方式：";
        self.payWay = dic[@"type"]?dic[@"type"]:@"";
        self.integral = dic[@"integral"]?dic[@"integral"]:@"";
        self.orderId = dic[@"orderId"]?dic[@"orderId"]:@"";
        self.updatedTime = dic[@"updatedTime"]?dic[@"updatedTime"]:@"";
        [self frame];
    }
    return self;
}

- (void)frame{
    // 店名
    CGSize maximumLabelSize = CGSizeMake(kViewWidth - kFRate(20), MAXFLOAT);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName: kFont24px};
    CGSize expectSize = [self.storeName boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    _storeNameF = CGRectMake(kFRate(10), kFRate(5), kViewWidth - kFRate(20), expectSize.height);
    _linOneF = CGRectMake(0, CGRectGetMaxY(_storeNameF) + kFRate(5), kViewWidth, kFRate(0.5));
    // 头像
    _topImgF = CGRectMake(kFRate(10), CGRectGetMaxY(_storeNameF) + kFRate(15), kFRate(75), kFRate(75));
    // 订单
    CGSize maximumLabelSize1 = CGSizeMake(MAXFLOAT, kFRate(20));//labelsize的最大值
    NSDictionary *attribute1 = @{NSFontAttributeName: kFont24px};
    CGSize expectSize1 = [self.order boundingRectWithSize:maximumLabelSize1 options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    _orderF = CGRectMake(CGRectGetMaxX(_topImgF) + kFRate(15), _topImgF.origin.y + kFRate(7.5), expectSize1.width, kFRate(20));
    _orderNumF = CGRectMake(CGRectGetMaxX(_orderF), _orderF.origin.y, kViewWidth - CGRectGetMaxX(_orderF), kFRate(20));
    // time
    CGSize maximumLabelSize2 = CGSizeMake(MAXFLOAT, kFRate(20));//labelsize的最大值
    NSDictionary *attribute2 = @{NSFontAttributeName: kFont24px};
    CGSize expectSize2 = [self.time boundingRectWithSize:maximumLabelSize2 options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute2 context:nil].size;
    _timeF = CGRectMake(_orderF.origin.x, CGRectGetMaxY(_orderF), expectSize2.width, kFRate(20));
    _orderTimeF = CGRectMake(CGRectGetMaxX(_timeF), _timeF.origin.y, kViewWidth - CGRectGetMaxX(_timeF), kFRate(20));
    // 支付
    CGSize maximumLabelSize3 = CGSizeMake(MAXFLOAT, kFRate(20));//labelsize的最大值
    NSDictionary *attribute3 = @{NSFontAttributeName: kFont24px};
    CGSize expectSize3 = [self.pay boundingRectWithSize:maximumLabelSize3 options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute3 context:nil].size;
    _payF = CGRectMake(_timeF.origin.x, CGRectGetMaxY(_timeF), expectSize3.width, kFRate(20));
    _payNumF = CGRectMake(CGRectGetMaxX(_payF), _payF.origin.y, kViewWidth - CGRectGetMaxX(_payF), kFRate(20));
    // 支付方式
    CGSize maximumLabelSize4 = CGSizeMake(MAXFLOAT, kFRate(20));//labelsize的最大值
    NSDictionary *attribute4 = @{NSFontAttributeName: kFont24px};
    CGSize expectSize4 = [self.way boundingRectWithSize:maximumLabelSize4 options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute4 context:nil].size;
    _wayF = CGRectMake(kFRate(10), CGRectGetMaxY(_topImgF) + kFRate(15), expectSize4.width, _storeNameF.size.height);
    _payWayF = CGRectMake(CGRectGetMaxX(_wayF), _wayF.origin.y, kViewWidth - CGRectGetMaxX(_wayF), _storeNameF.size.height);
    _linTwoF = CGRectMake(0, _wayF.origin.y - kFRate(5), kViewWidth, kFRate(0.5));
    
    _cellH = CGRectGetMaxY(_payWayF) + kFRate(5) + kFRate(5);
}

@end
