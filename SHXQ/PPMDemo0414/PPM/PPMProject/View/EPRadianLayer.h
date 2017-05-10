//
//  EPRadianLayer.h
//  E-Platform
//
//  Created by luchanghao on 17/2/17.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface EPRadianLayer : CAShapeLayer
@property (nonatomic, assign) CGFloat radius;

+ (instancetype)radianWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color;
@end
