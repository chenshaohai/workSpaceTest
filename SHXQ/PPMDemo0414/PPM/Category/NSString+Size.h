//
//  NSDictionary+Null.h
//  E-Platform
//
//  Created by Apple on 2017/3/16.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

/**
  根据指定文本,字体和最大高度计算尺寸
 @param text 文字
 @param font 文字
 @param height 高度
 @return 尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxHeight:(CGFloat)height;

/**
 根据指定文本,字体和最大宽度计算尺寸

 @param text 文字
 @param font 文字
 @param width 宽度
 @return 尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width;
@end
