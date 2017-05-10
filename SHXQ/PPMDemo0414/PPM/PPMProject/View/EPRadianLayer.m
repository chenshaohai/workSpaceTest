//
//  EPRadianLayer.m
//  E-Platform
//
//  Created by luchanghao on 17/2/17.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "EPRadianLayer.h"

@interface EPRadianLayer ()
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, strong) UIColor *color;
@end

@implementation EPRadianLayer
+(instancetype)radianWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color{
    return [[self alloc] initWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle color:color];
}

- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color
{
    self = [super init];
    if (self) {
        self.fillColor = nil;
        self.strokeColor = color.CGColor;
        _center =center;
        _startAngle = startAngle;
        _endAngle = endAngle;
        _color = color;
        self.path = [self bezierWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle color:color].CGPath;
    }
    return self;
}

-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    self.path = [self bezierWithCenter:_center radius:radius startAngle:_startAngle endAngle:_endAngle color:_color].CGPath;
}


- (UIBezierPath *)bezierWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color
{
    UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    return bezier;
}

@end
