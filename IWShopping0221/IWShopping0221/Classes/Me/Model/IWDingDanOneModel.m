//
//  IWDingDanOneModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDingDanOneModel.h"
// 名字固定宽度
#define kWidth kFRate(70)
// 左右间距
#define KWdis kFRate(10)
// 上下间距
#define kHdis kFRate(10)

@implementation IWDingDanOneModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // 订单信息
        _orderContent = @"订单信息";
        
        _number = @"订单编号";
        _orderNum = dic[@"orderNum"]?dic[@"orderNum"]:@"";
        
        _time = @"创建时间";
        _createTime = [NSDate dateToyyyyMMddHHmmssStringWithInteger:[dic[@"createTime"]?dic[@"createTime"]:@"" doubleValue]];
        
        _state = @"订单状态";
        _orderState = dic[@"orderState"]?dic[@"orderState"]:@"";

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
    
    CGSize stateSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_state];
    _stateF = CGRectMake(KWdis, CGRectGetMaxY(_timeF) + kHdis, kWidth, stateSize.height);
    CGSize orderStateSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kFont24px text:_orderState];
    _orderStateF = CGRectMake(CGRectGetMaxX(_stateF), CGRectGetMaxY(_timeF) + kHdis, orderStateSize.width, orderStateSize.height);
    
    _cellH = CGRectGetMaxY(_stateF) + kFRate(20);
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}

@end
