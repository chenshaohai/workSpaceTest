//
//  NSDictionary+Null.m
//  E-Platform
//
//  Created by Apple on 2017/3/16.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
// 根据指定文本,字体和最大高度计算尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxHeight:(CGFloat)height
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}

// 根据指定文本,字体和最大宽度计算尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}
@end
