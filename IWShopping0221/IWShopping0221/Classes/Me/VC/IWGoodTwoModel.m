//
//  IWGoodTwoModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGoodTwoModel.h"
// 左右间距
#define KWdis kFRate(10)
// 上下间距
#define kHdis kFRate(10)
@implementation IWGoodTwoModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // 店铺
        _productId = dic[@"productId"]?dic[@"productId"]:@"";
        _shopName = dic[@"shopName"]?dic[@"shopName"]:@"";
        _goodsImg = dic[@"thumbImg"]?dic[@"thumbImg"]:@"";
        _goodsName = dic[@"productName"]?dic[@"productName"]:@"";
        _goodsSku = dic[@"attributeValue"]?dic[@"attributeValue"]:@"";
        // ¥
        CGFloat goodsPriceF = [dic[@"salePrice"]?dic[@"salePrice"]:@"0" floatValue];
        _goodsPrice = [NSString stringWithFormat:@"退款金额：¥%.2f",goodsPriceF];
        _shopNum = [NSString stringWithFormat:@"x%@",dic[@"refundCount"]?dic[@"refundCount"]:@""];
        NSNumber *num = dic[@"refundType"]?dic[@"refundType"]:@"";
        switch ([num integerValue]) {
            case 1:
                _shopState = @"只退款";
                break;
            case 2:
                _shopState = @"只退货";
                break;
            case 3:
                _shopState = @"退款并退货";
                break;
            case 4:
                _shopState = @"换货";
                break;
                
            default:
                break;
        }
        [self frame];
    }
    return self;
}
- (void)frame{
    // 收货信息
    _tableThreeF = CGRectMake(0, 0, kViewWidth, kFRate(30));
    _shopImgF = CGRectMake(KWdis, kFRate(5), kFRate(20), kFRate(20));
    _shopNameF = CGRectMake(kFRate(40), 0, kViewWidth - kFRate(50), kFRate(30));
    _linThreeF = CGRectMake(KWdis, kFRate(30.5), kViewWidth - KWdis * 2, kFRate(0.5));
    
    // 图片
    _goodsImgF = CGRectMake(KWdis, CGRectGetMaxY(_linThreeF) + kFRate(15), kFRate(65), kFRate(65));
    // 名字
    CGSize nameSize = [self initWithWidth:kViewWidth - CGRectGetMaxX(_goodsImgF) - kFRate(10) - kFRate(50) height:MAXFLOAT font:kFont24px text:_goodsName];
    _goodsNameF = CGRectMake(CGRectGetMaxX(_goodsImgF) + KWdis, CGRectGetMaxY(_linThreeF) + kFRate(15), nameSize.width, nameSize.height);
    
    // 规格
    CGSize goodsSkuSize = [self initWithWidth:kViewWidth - CGRectGetMaxX(_goodsImgF) - kFRate(10) - kFRate(50) height:MAXFLOAT font:kFont24px text:_goodsSku];
    _goodsSkuF = CGRectMake(CGRectGetMaxX(_goodsImgF) + KWdis, CGRectGetMaxY(_goodsNameF) + kFRate(14), goodsSkuSize.width, goodsSkuSize.height);
    
    // 价格
    CGSize goodsPrice = [self initWithWidth:kViewWidth - CGRectGetMaxX(_goodsImgF) - kFRate(10) - kFRate(50) height:MAXFLOAT font:kFont24px text:_goodsPrice];
    _goodsPriceF = CGRectMake(CGRectGetMaxX(_goodsImgF) + KWdis, CGRectGetMaxY(_goodsSkuF) + kFRate(9), goodsPrice.width, goodsPrice.height);
    
    // 下分割线
    if (CGRectGetMaxY(_goodsPriceF) <= CGRectGetMaxY(_goodsImgF)) {
        // 数量
        _shopNumF = CGRectMake(kViewWidth - kFRate(40), CGRectGetMaxY(_linThreeF), kFRate(30), _goodsImgF.size.height + kFRate(15));
    }else{
        // 数量
        _shopNumF = CGRectMake(kViewWidth - kFRate(40), CGRectGetMaxY(_linThreeF), kFRate(30), CGRectGetMaxY(_goodsPriceF) - CGRectGetMaxY(_linThreeF) + kFRate(15));
    }

    _shopStateF = CGRectMake(kViewWidth - kFRate(110), _goodsPriceF.origin.y, kFRate(100), _goodsPriceF.size.height);
    
    _cellH = CGRectGetMaxY(_shopNumF) + kFRate(10);
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}
@end
