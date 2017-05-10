//
//  TQStarRatingView.m
//  TQStarRatingView
//
//  Created by fuqiang on 13-8-28.
//  Copyright (c) 2013年 TinyQ. All rights reserved.
// 五角星框架



#import "TQStarRatingView.h"

@interface TQStarRatingView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;
@property (nonatomic, assign) BOOL isLarge;

@end

@implementation TQStarRatingView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:5 large:NO];
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number large:(BOOL)isLarge
{
    self = [super initWithFrame:frame];
    if (self) {
        _isLarge = isLarge;
        _numberOfStar = number;
        if (isLarge) {
            self.starBackgroundView = [self buidlStarViewWithImageName:@"background_star_large"];
            self.starForegroundView = [self buidlStarViewWithImageName:@"foreground_star_large"];
        }else{
            self.starBackgroundView = [self buidlStarViewWithImageName:@"background_star"];
            self.starForegroundView = [self buidlStarViewWithImageName:@"foreground_star"];
        }
        [self addSubview:self.starBackgroundView];
        [self addSubview:self.starForegroundView];
    }
    return self;
}

# pragma mark  通过分数得到 黄色星星位置
/**
 *   通过分数得到 黄色星星位置
 */
- (void)setRatingViewScore:(int)score
{
    
    NSLog(@"------%d-----",score);
    
    CGPoint point = CGPointZero;
    if (_isLarge) {  //详情页面星星的宽度 47    因为整课星星的原因，减少到46
        point = CGPointMake(kFRate(46.0) * score, 0);
    }else{           // 汇总时星星的宽度  18
        point = CGPointMake(kFRate(18.0) * score, 0);
    }
    [self changeStarForegroundViewWithPoint:point];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (0 < point.x  ) {
  

    }
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point))
    {
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak TQStarRatingView * weekSelf = self;
    
    [UIView transitionWithView:self.starForegroundView
                      duration:0.2
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^
     {
         [weekSelf changeStarForegroundViewWithPoint:point];
     }
                    completion:^(BOOL finished)
     {
    
     }];
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    float starWeight = self.frame.size.width / self.numberOfStar ;
    

    if (p.x < 0)
    {
        p.x = 0;
    }else if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }else  { //整棵星星添加的代码
        int  index = 0 ;
        for (; index < self.numberOfStar && p.x > starWeight * index  ; index ++) {        }
        p.x = starWeight * index ;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    p.x = score * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x , self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)])
    {
        [self.delegate starRatingView:self score:score];
    }
}

@end
