//
//  EPDrawPieModel.m
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPDrawPieModel.h"

@interface EPDrawPieModel()
{
    double _totalValue;
    double _startAngle;
}
@end

@implementation EPDrawPieModel

-(void)setForFrame{
    _startAngle = (-90/180.f)*M_PI;
    [self getAngleForView];
}


-(void)getAngleForView{
    
    self.angleArray = [NSMutableArray new];
    self.startAngleArray = [NSMutableArray new];
    _totalValue = 0;
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        _totalValue += [_valueArray[i] floatValue];
    }
    
    //设置全部角度
    [_startAngleArray addObject:@(_startAngle)];
    for (NSInteger i = 0; i < _valueArray.count; i++) {
        
        CGFloat angle = [self countAngle:[_valueArray[i] floatValue]];
        
        [_angleArray addObject:@(angle)];
        
        [_startAngleArray addObject:@([_startAngleArray[i] floatValue] + angle)];
    }
}

- (CGFloat)countAngle:(CGFloat)value{
    //计算百分比
    CGFloat percent = value / _totalValue;
    //需要多少度的圆弧
    CGFloat angle = M_PI * 2 * percent;
    return angle;
}

@end
