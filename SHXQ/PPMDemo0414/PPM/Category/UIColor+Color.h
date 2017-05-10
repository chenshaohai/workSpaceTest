//
//  UIColor+Color.h
//  十六进制颜色
//
//  Created by admin on 16/8/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Color)
+ (UIColor *) HexColorToRedGreenBlue: (NSString *)color;
+ (UIColor *) HexColorToRedGreenBlue: (NSString *)color alpha:(CGFloat)alpha;
@end
