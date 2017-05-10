//
//  IWTuiHuanWuLiuModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/29.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWTuiHuanWuLiuModel.h"
// 名字固定宽度
#define kWidth kFRate(70)
// 左右间距
#define KWdis kFRate(10)
// 上下间距
#define kHdis kFRate(10)
@implementation IWTuiHuanWuLiuModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        //        _attributeValue = dic[@"attributeValue"]?dic[@"attributeValue"]:@"";
        //        _createdTime = dic[@"createdTime"]?dic[@"createdTime"]:@"";
        //        _itemId = dic[@"itemId"]?dic[@"itemId"]:@"";
        //        _orderDetailId = dic[@"orderDetailId"]?dic[@"orderDetailId"]:@"";
        //        _orderId = dic[@"orderId"]?dic[@"orderId"]:@"";
        //        _productId = dic[@"productId"]?dic[@"productId"]:@"";
        //        _productName = dic[@"productName"]?dic[@"productName"]:@"";
        //        _refundCount = dic[@"refundCount"]?dic[@"refundCount"]:@"";
        //        _refundId = dic[@"refundId"]?dic[@"refundId"]:@"";
        //        _refundMoney = dic[@"refundMoney"]?dic[@"refundMoney"]:@"";
        //        _refundNum = dic[@"refundNum"]?dic[@"refundNum"]:@"";
        //        _refundReason = dic[@"refundReason"]?dic[@"refundReason"]:@"";
        //        _refundType = dic[@"refundType"]?dic[@"refundType"]:@"";
        //        _salePrice = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        //        _shopId = dic[@"shopId"]?dic[@"shopId"]:@"";
        //        _shopName = dic[@"shopName"]?dic[@"shopName"]:@"";
        //        _smarketPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"";
        //        _state = dic[@"state"]?dic[@"state"]:@"";
        //        _thumbImg = dic[@"thumbImg"]?dic[@"thumbImg"]:@"";
        //        _updatedTime = dic[@"updatedTime"]?dic[@"updatedTime"]:@"";
        
        // 订单信息
        _orderContent = @"物流信息";
        
        _number = @"物流公司";
        _orderNum = dic[@"ShipperCode"]?dic[@"ShipperCode"]:@"";
        
        _time = @"物流单号";
        _createTime = dic[@"LogisticCode"]?dic[@"LogisticCode"]:@"";

        
        [self frame];
    }
    return self;
}
- (void)frame{
    // 订单信息
    _tableOneF = CGRectMake(0, 0, kViewWidth, kFRate(30));
    _orderContentF = CGRectMake(KWdis, 0, kViewWidth - KWdis * 2, kFRate(30));
    _linOneF = CGRectMake(KWdis, kFRate(30.5), kViewWidth - KWdis * 2, kFRate(0.5));
    
    CGSize numSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_number];
    _numF = CGRectMake(KWdis, CGRectGetMaxY(_linOneF) + kHdis, kWidth, numSize.height);
    CGSize orderNumSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kFont24px text:_orderNum];
    _orderNumF = CGRectMake(CGRectGetMaxX(_numF), CGRectGetMaxY(_linOneF) + kHdis, orderNumSize.width, orderNumSize.height);
    
    CGSize timeSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_time];
    _timeF = CGRectMake(KWdis, CGRectGetMaxY(_numF) + kHdis, kWidth, timeSize.height);
    CGSize createTimeSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kFont24px text:_createTime];
    _createTimeF = CGRectMake(CGRectGetMaxX(_timeF), CGRectGetMaxY(_numF) + kHdis, createTimeSize.width, createTimeSize.height);
    
    _cellH = CGRectGetMaxY(_createTimeF) + kFRate(20);
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}
@end
