//
//  IWToViewModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/13.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWToViewModel.h"

@implementation IWToViewModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _AcceptStation = dic[@"AcceptStation"]?dic[@"AcceptStation"]:@"";
        _AcceptTime = dic[@"AcceptTime"]?dic[@"AcceptTime"]:@"";
        _Remark = dic[@"Remark"]?dic[@"Remark"]:@"";
        [self frame];
    }
    return self;
}

- (void)frame{
    // 圆点图标
    _imgF = CGRectMake(kFRate(10), kFRate(17), kFRate(15), kFRate(15));
    
    // 线条
    _linSF = CGRectMake(kFRate(17.5), 0, kFRate(0.5), kFRate(17));
    
    // 送货内容
    CGSize contentSize = [self initWithWidth:kViewWidth - CGRectGetMaxX(_imgF) - kFRate(20) height:MAXFLOAT font:kFont28px text:_AcceptStation];
    _contentF = CGRectMake(CGRectGetMaxX(_imgF) + kFRate(10), kFRate(15), contentSize.width, contentSize.height);
    
    // 时间
    CGSize timeSize = [self initWithWidth:kViewWidth - CGRectGetMaxX(_imgF) - kFRate(20)  height:MAXFLOAT font:kFont24px text:_AcceptTime];
    _timeF = CGRectMake(_contentF.origin.x, CGRectGetMaxY(_contentF) + kFRate(15), kViewWidth - CGRectGetMaxX(_imgF) - kFRate(20), timeSize.height);
    
    _cellH = CGRectGetMaxY(_timeF) + kFRate(15);
    
    // 下线条
    _linXF = CGRectMake(_linSF.origin.x, CGRectGetMaxY(_imgF), kFRate(0.5), _cellH - CGRectGetMaxY(_imgF));
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}

@end
