//
//  IWDingDanFourModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDingDanFourModel.h"
// 名字固定宽度
#define kWidth kFRate(70)
// 左右间距
#define KWdis kFRate(10)
// 上下间距
#define kHdis kFRate(10)

@implementation IWDingDanFourModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // 订单金额
        _orderSum = @"订单金额";
        
        _total = @"订单总金额";
        CGFloat orderTotalF = [dic[@"orderTotal"]?dic[@"orderTotal"]:@"0" floatValue];
        _orderTotal = [NSString stringWithFormat:@"¥%.2f",orderTotalF];
        
        _yunFei = @"运费";
        CGFloat freightF = [dic[@"freight"]?dic[@"freight"]:@"0" floatValue];
        _freight = [NSString stringWithFormat:@"+ ¥%.2f",freightF];
        
        _zheKou = @"会币抵扣";
        //@"- ¥100.00"
        if ([dic[@"discount"]?dic[@"discount"]:@"0" floatValue] == 0.00) {
            _discount = [NSString stringWithFormat:@"- ¥0.00"];
        }else{
            _discount = [NSString stringWithFormat:@"- ¥%.2f",[dic[@"discount"]?dic[@"discount"]:@"0" floatValue]];
        }
        
        [self frame];
    }
    return self;
}
- (void)frame{
    // 订单金额
    _tableFourF = CGRectMake(0, 0, kViewWidth, kFRate(30));
    _orderSumF = CGRectMake(KWdis, 0, kViewWidth - KWdis * 2, kFRate(30));
    _linFourF = CGRectMake(KWdis, kFRate(30.5), kViewWidth - KWdis * 2, kFRate(0.5));
    
    CGSize totalSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_total];
    _totalF = CGRectMake(KWdis, CGRectGetMaxY(_linFourF) + kHdis, kWidth, totalSize.height);
    _orderTotalF = CGRectMake(kViewWidth - kFRate(110), CGRectGetMaxY(_linFourF) + kHdis, kFRate(100), _totalF.size.height);
    
    CGSize yuFeiSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_yunFei];
    _yuFeiF = CGRectMake(KWdis, CGRectGetMaxY(_totalF) + kHdis, kWidth, yuFeiSize.height);
    _freightF = CGRectMake(kViewWidth - kFRate(110), CGRectGetMaxY(_totalF) + kHdis, kFRate(100), _yuFeiF.size.height);
    
    CGSize zheKouSize = [self initWithWidth:kWidth height:MAXFLOAT font:kFont24px text:_zheKou];
    _zheKouF = CGRectMake(KWdis, CGRectGetMaxY(_yuFeiF) + kHdis, kWidth, zheKouSize.height);
    _discountF = CGRectMake(kViewWidth - kFRate(110), CGRectGetMaxY(_yuFeiF) + kHdis, kFRate(100), _zheKouF.size.height);
    
    _cellH = CGRectGetMaxY(_zheKouF) + kFRate(10);
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}
@end
