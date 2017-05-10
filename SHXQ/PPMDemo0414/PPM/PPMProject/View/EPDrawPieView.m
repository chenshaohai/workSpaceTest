//
//  EPDrawPieView.m
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPDrawPieView.h"
//#import "EPLinePie.h"
#import "EPRadianLayer.h"

@interface EPDrawPieView ()
@property (nonatomic, strong) NSMutableArray *pieArray;
@end

@implementation EPDrawPieView

-(void)setSelectIndex:(long)selectIndex{
    
    if (selectIndex > _pieArray.count) return;
    
    _selectIndex = selectIndex;
    
    for (EPRadianLayer *layer in _pieArray) {
        layer.radius = _model.radius;
        layer.lineWidth = _model.lineWidth;
    }
    [_pieArray[selectIndex] setLineWidth:_model.lineWidth + 0.3*_model.lineWidth];
    
    [_pieArray[selectIndex] setRadius:_model.radius + 0.15*_model.lineWidth];
    
    [self setNeedsDisplay];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_couldTouch) return;
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    CGPoint centerPoint = CGPointMake(self.width/2, self.height/2);
    CGFloat ww = sqrtf((touchPoint.x - centerPoint.x) * (touchPoint.x - centerPoint.x)  + (touchPoint.y - centerPoint.y) * (touchPoint.y - centerPoint.y));
    
    
    if (ww< _model.radius + _model.lineWidth/2
        && ww> _model.radius - _model.lineWidth/2) {
        NSLog(@"1111");
        
        //求弧度
        CGFloat x = (touchPoint.x - centerPoint.x);
        CGFloat y = (touchPoint.y - centerPoint.y);
        CGFloat radian = atan2(y, x);
        //当超过180度时，要加2π
        if (y < 0 && x < 0) {
            radian = radian + (360 / 180.f * M_PI);
        }
        
        //判断点击位置的角度在哪个path范围上
        for (NSInteger i = 0; i < _model.valueArray.count; i++) {
            CGFloat startAngle = [_model.startAngleArray[i] floatValue];
            CGFloat endAngle   = [_model.startAngleArray[i+1] floatValue];
            
            if (radian >= startAngle && radian < endAngle) {
                NSLog(@"%@",_pieArray[i]);
                
                for (EPRadianLayer *layer in _pieArray) {
                    layer.radius = _model.radius;
                    layer.lineWidth = _model.lineWidth;
                }
                [_pieArray[i] setLineWidth:_model.lineWidth + 0.3*_model.lineWidth];

                [_pieArray[i] setRadius:_model.radius + 0.15*_model.lineWidth];
                
                [self setNeedsDisplay];
                
                if (_block) {
                    _block(i);
                }
            }
        }
    }
}


-(void)setModel:(EPDrawPieModel *)model{
    _model = model;
    [self drawPie];
}

-(void)drawPie{
    [self setupLoop];
}

-(void)setupLoop{

    self.pieArray = [NSMutableArray array];
    
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    for (int i = 0; i<_model.valueArray.count; i++) {
        
        CGFloat startAngle = [_model.startAngleArray[i] floatValue];
        CGFloat endAngle   = [_model.startAngleArray[i+1] floatValue];
    
        
        EPRadianLayer * pie = [EPRadianLayer radianWithCenter:CGPointMake(self.width/2, self.height/2) radius:_model.radius startAngle:startAngle endAngle:endAngle color:_model.colorArray[i]];
        
        pie.lineWidth = _model.lineWidth;

        [self.layer addSublayer:pie];
        
        [_pieArray addObject:pie];
    }
}

@end
