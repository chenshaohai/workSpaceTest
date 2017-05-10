//
//  IWHomeRegionProductModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/1.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeRegionProductModel.h"

@implementation IWHomeRegionProductModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.idStr = dic[@"id"]?dic[@"id"]:@"";
        self.integral = dic[@"integral"]?dic[@"integral"]:@"0";
        if ([self.integral isEqual:@""] || [self.integral isKindOfClass:[NSNull class]]) {
            self.integral = @"0";
        }
        self.productId = dic[@"productId"]?dic[@"productId"]:@"";
        self.productName = dic[@"productName"]?dic[@"productName"]:@"";
        self.saleCount = dic[@"saleCount"]?dic[@"saleCount"]:@"";
        self.salePrice = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        self.smarketPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"";
        self.stock = dic[@"stock"]?dic[@"stock"]:@"";
        self.thumbImg = dic[@"thumbImg"]?dic[@"thumbImg"]:@"";
        
        [self frame];
    }
    return self;
}

- (void)frame{
    CGFloat showPriceF = [_salePrice floatValue];
    CGFloat integralF = [_integral floatValue];
    NSString *text = [NSString stringWithFormat:@"%.2f+%.0f贝壳",showPriceF,integralF];
    CGSize size = [self initWithWidth:kRate(93) height:MAXFLOAT font:kFont34px text:text];
    _textH = size.height;
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}

@end
