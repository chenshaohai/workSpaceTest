//
//  IWGoodsThreeModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGoodsThreeModel.h"
// 名字固定宽度
#define kWidth kFRate(70)
// 左右间距
#define KWdis kFRate(10)
// 上下间距
#define kHdis kFRate(10)
@implementation IWGoodsThreeModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _orderContent = @"退换原因";
        _content = dic[@"refundReason"]?dic[@"refundReason"]:@"";
        
        [self frame];
    }
    return self;
}

- (void)frame{
    _tableOneF = CGRectMake(0, 0, kViewWidth, kFRate(30));
    _orderContentF = CGRectMake(KWdis, 0, kViewWidth - KWdis * 2, kFRate(30));
    _linOneF = CGRectMake(KWdis, kFRate(30.5), kViewWidth - KWdis * 2, kFRate(0.5));
    
    CGSize size = [self initWithWidth:kViewWidth - kFRate(20) height:MAXFLOAT font:kFont24px text:_content];
    _contentF = CGRectMake(kFRate(10), CGRectGetMaxY(_linOneF), kViewWidth - kFRate(20), size.height + kFRate(20));
    
    _cellH = CGRectGetMaxY(_contentF);
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}

@end
