//
//  AActivityIndicicator.m
//  自定义加载中
//
//  Created by FRadmin on 16/7/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AActivityIndicicator.h"
@interface AActivityIndicicator()
@property (strong,nonatomic) CAGradientLayer * indicatorLayer;
@property (strong,nonatomic) CAShapeLayer * shapeLayer;
@property (assign,nonatomic) BOOL visible;
@end
@implementation AActivityIndicicator

-(CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.bounds = CGRectMake(0, 0, kFRate(50),kFRate(50));
        _shapeLayer.position = CGPointMake(kFRate(25),kFRate(25));
        _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        CGMutablePathRef path = CGPathCreateMutable();
        _shapeLayer.lineWidth = kFRate(3.5);
//        _shapeLayer.backgroundColor = [UIColor purpleColor].CGColor;
        CGPathAddArc(path, nil,kFRate(25), kFRate(25),kFRate(22.5),0,2*M_PI,YES);
        _shapeLayer.path = path;
        //        roundShape.path
    }
    return _shapeLayer;
}
-(CAGradientLayer *)indicatorLayer{
    if (!_indicatorLayer){
        _indicatorLayer = [[CAGradientLayer alloc] init];
        _indicatorLayer.bounds = CGRectMake(0, 0, kFRate(50),kFRate(50));
        _indicatorLayer.position = CGPointMake(kFRate(25),kFRate(25));
//        _indicatorLayer.colors = @[(id)[UIColor blackColor].CGColor,
//                                   (id)[UIColor grayColor].CGColor,
//                                   (id)[UIColor blackColor].CGColor];
        _indicatorLayer.colors = @[(id)[UIColor blackColor].CGColor,
                                   (id)[UIColor grayColor].CGColor];
        // 颜色分割线
        _indicatorLayer.locations  = @[@(0.25), @(0.5), @(0.75)];
        _indicatorLayer.startPoint = CGPointMake(0.0, 0.0);
        _indicatorLayer.endPoint = CGPointMake(1.0,1.0);
        _indicatorLayer.masksToBounds = YES;
        [_indicatorLayer setMask:self.shapeLayer];
    }
    return _indicatorLayer;
}
-(void)start{
//    self.hidden = NO;
//    [UIView animateWithDuration:0.8
//                          delay:0
//                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         self.transform = CGAffineTransformMakeRotation(M_PI);
//                     } completion:^(BOOL finished) {
//                         
//                     }];
    
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithDouble:0];

    rotationAnimation.toValue = [NSNumber numberWithDouble:M_PI*2];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:rotationAnimation forKey:@"transform.rotation.z"];
}
-(void)stop{
    [self removeFromSuperview];
//    [self.indicatorLayer removeAllAnimations];
//    self.hidden = YES;
}

-(void)setUp{
    self.bounds = CGRectMake(0, 0,kFRate(50),kFRate(50));
    [self.layer addSublayer:self.indicatorLayer];
//    self.hidden = YES;
}
-(instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

@end
