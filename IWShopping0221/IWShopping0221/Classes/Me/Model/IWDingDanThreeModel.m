//
//  IWDingDanThreeModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDingDanThreeModel.h"
// 左右间距
#define KWdis kFRate(10)
// 上下间距
#define kHdis kFRate(10)

@implementation IWDingDanThreeModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // 店铺
        _goodsImg = dic[@"goodsImg"]?dic[@"goodsImg"]:@"";
        _goodsName = dic[@"goodsName"]?dic[@"goodsName"]:@"";
        _goodsSku = dic[@"goodsSku"]?dic[@"goodsSku"]:@"";
        // ¥
        CGFloat goodsPriceF = [dic[@"goodsPrice"]?dic[@"goodsPrice"]:@"0" floatValue];
        _goodsPrice = [NSString stringWithFormat:@"¥%.2f",goodsPriceF];
        
        _shopNum = [NSString stringWithFormat:@"x%@",dic[@"shopNum"]?dic[@"shopNum"]:@""];
        
        [self frame];
    }
    return self;
}
- (void)frame{
    // 收货信息
    
    // 图片
    _goodsImgF = CGRectMake(KWdis, kFRate(15), kFRate(65), kFRate(65));
    // 名字
    CGSize nameSize = [self initWithWidth:kViewWidth - CGRectGetMaxX(_goodsImgF) - kFRate(10) - kFRate(50) height:MAXFLOAT font:kFont24px text:_goodsName];
    _goodsNameF = CGRectMake(CGRectGetMaxX(_goodsImgF) + KWdis, kFRate(15), nameSize.width, nameSize.height);
    
    // 规格
    CGSize goodsSkuSize = [self initWithWidth:kViewWidth - CGRectGetMaxX(_goodsImgF) - kFRate(10) - kFRate(50) height:MAXFLOAT font:kFont24px text:_goodsSku];
    _goodsSkuF = CGRectMake(CGRectGetMaxX(_goodsImgF) + KWdis, CGRectGetMaxY(_goodsNameF) + kFRate(14), goodsSkuSize.width, goodsSkuSize.height);
    
    // 价格
    CGSize goodsPrice = [self initWithWidth:kViewWidth - CGRectGetMaxX(_goodsImgF) - kFRate(10) - kFRate(50) height:MAXFLOAT font:kFont24px text:_goodsPrice];
    _goodsPriceF = CGRectMake(CGRectGetMaxX(_goodsImgF) + KWdis, CGRectGetMaxY(_goodsSkuF) + kFRate(9), goodsPrice.width, goodsPrice.height);
    
    // 下分割线
    if (CGRectGetMaxY(_goodsPriceF) <= CGRectGetMaxY(_goodsImgF)) {
        _linFiveF = CGRectMake(KWdis, CGRectGetMaxY(_goodsImgF) + kFRate(15), kViewWidth - KWdis * 2, kFRate(0.5));
    }else{
        _linFiveF = CGRectMake(KWdis, CGRectGetMaxY(_goodsPriceF) + kFRate(15), kViewWidth - KWdis * 2, kFRate(0.5));
    }
    
    // 数量
    _shopNumF = CGRectMake(kViewWidth - kFRate(40), CGRectGetMaxY(_linThreeF), kFRate(30), CGRectGetMaxY(_linFiveF) - CGRectGetMaxY(_linThreeF));

    
    _cellH = CGRectGetMaxY(_linFiveF);
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}
@end
