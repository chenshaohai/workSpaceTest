//
//  EPPmStatisticsPieView.m
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPPmStatisticsPieView.h"
#import "EPDrawPieView.h"
#import "UIView+Frame.h"
//#import "EPRequestAdapter.h"

@interface EPPmStatisticsPieView()<EPPmStatisticsPieViewDelegate>
{
    CGFloat _doing;
    CGFloat _done;
    CGFloat _todo;
}
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *totalLab;
@property (nonatomic, strong) UILabel *unDoneLab;
@property (nonatomic, strong) UILabel *finishLab;

@property (nonatomic, strong) UILabel *percentageLab;
@property (nonatomic, strong) UILabel *percentageDetailLab;

@property (nonatomic, strong) EPDrawPieView *drawPieView;

@property(nonatomic,assign)EPPmPieViewType type;

@end

@implementation EPPmStatisticsPieView
-(instancetype)initWithFrame:(CGRect)frame andType:(EPPmPieViewType)type{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_HEX(0xffffff);
        self.type = type;
        
        [self setupPie];
        [self setup];
        [self setdata];
    }
    return self;

}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_HEX(0xffffff);
        [self setupPie];
        [self setup];
        [self setdata];
    }
    return self;
}

-(void)setup{
    //标题
    self.titleLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 36))];
    _titleLab.top = 0;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = MyFont(14);
    _titleLab.textColor = COLOR_HEX(0x333333);
    [self addSubview:_titleLab];
    
    //线
    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 0.5))];
    line.bottom = self.titleLab.height;
    [self addSubview:line];
    line.backgroundColor = COLOR_HEX(0xdedede);
    
    UIImageView *arrawImg = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 30, 30))];
    arrawImg.centerY = _drawPieView.centerY;
    arrawImg.right = SCREEN_WIDTH - 16;
    arrawImg.contentMode = 1;
    //[self addSubview:arrawImg];
    arrawImg.image = __IMG__(@"EPClockInApplyVCjiantou");
    
    
    self.totalLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 100, 15))];
    _totalLab.top = 80;
    _totalLab.left = arrawImg.left - (70 + 50)/3;
    _totalLab.textColor = COLOR_HEX(0x666666);
    _totalLab.font = [UIFont systemFontOfSize:12];
    _totalLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_totalLab];
    //任务总数
    UILabel *lab1 = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 100, 15))];
    
        lab1.text =@"项目总数";
   
    lab1.textColor = COLOR_HEX(0x666666);
    lab1.font = [UIFont systemFontOfSize:12];
    lab1.textAlignment = NSTextAlignmentRight;
    lab1.right = _totalLab.left - 84/3;
    lab1.centerY = _totalLab.centerY;
    [self addSubview: lab1];
    
    
    
    self.unDoneLab = [[UILabel alloc] initWithFrame:_totalLab.frame];
    _unDoneLab.top = _totalLab.bottom +22.6;
    _unDoneLab.textColor = COLOR_HEX(0x666666);
    _unDoneLab.font = _totalLab.font;
    _unDoneLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_unDoneLab];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 100, 15))];
    lab2.text =@"未完成";
    lab2.textColor = COLOR_HEX(0x666666);
    lab2.font = [UIFont systemFontOfSize:12];
    lab2.textAlignment = NSTextAlignmentRight;
    lab2.right = _unDoneLab.left - 84/3;
    lab2.centerY = _unDoneLab.centerY;
    [self addSubview: lab2];
    
    
    UIView *unDoneColor = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 12, 12))];
    unDoneColor.backgroundColor = COLOR_HEX(0xfa8e4e);
    unDoneColor.centerY = _unDoneLab.centerY;
    unDoneColor.right = lab2.right - 40;
    [self addSubview:unDoneColor];
    
    
    
    
    
    self.finishLab = [[UILabel alloc] initWithFrame:_unDoneLab.frame];
    _finishLab.top = _unDoneLab.bottom +22.6;
    _finishLab.textColor = COLOR_HEX(0x666666);
    _finishLab.font = _totalLab.font;
    _finishLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_finishLab];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 100, 15))];
    lab3.text =@"已完成";
    lab3.textColor = COLOR_HEX(0x666666);
    lab3.font = [UIFont systemFontOfSize:12];
    lab3.textAlignment = NSTextAlignmentRight;
    lab3.right = _finishLab.left - 84/3;
    lab3.centerY = _finishLab.centerY;
    [self addSubview: lab3];
    
    
    UIView *finishColor = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 12, 12))];
    finishColor.backgroundColor = COLOR_HEX(0x84d947);
    finishColor.centerY = _finishLab.centerY;
    finishColor.right = lab3.right - 40;
    [self addSubview:finishColor];
    
    
    
    
    UIView *lineDown = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 0.5))];
    lineDown.bottom = self.height;
    [self addSubview:lineDown];
    lineDown.backgroundColor = COLOR_HEX(0xdedede);

}
#pragma mark 圆环
-(void)setupPie{
    self.drawPieView = [[EPDrawPieView alloc] initWithFrame:CGRectMake(0, 0, 400/3, 400/3)];
    _drawPieView.centerY = 374/3;
    _drawPieView.centerX = 320/3;
    _drawPieView.couldTouch = YES;
    
    if (SCREEN_WIDTH <= 320) {
        _drawPieView.left -=20;
    }
    
    [self addSubview:_drawPieView];
    
    self.percentageDetailLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 80, 15))];
    _percentageDetailLab.centerX = _drawPieView.centerX;
    _percentageDetailLab.centerY = _drawPieView.centerY - 8;
    _percentageDetailLab.text = @"完成率";
    _percentageDetailLab.textColor = COLOR_HEX(0x666666);
    _percentageDetailLab.font = MyFont(11);
    _percentageDetailLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_percentageDetailLab];
    
    self.percentageLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 100, 16))];
    _percentageLab.centerX = _drawPieView.centerX;
    _percentageLab.centerY = _drawPieView.centerY + 8;
    _percentageLab.textColor = COLOR_HEX(0x333333);
    _percentageLab.font = [UIFont boldSystemFontOfSize:14];
    _percentageLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_percentageLab];

    
    WEAKSELF;
    //点击回调
    _drawPieView.block = ^(long index){
        if (index == 0) {
            weakSelf.percentageLab.text = [NSString stringWithFormat:@"%.1f%%",_done/(_doing + _done +_todo) * 100];
            if ((_doing + _done +_todo) == 0) {
                weakSelf.percentageLab.text = @"0";
            }
            weakSelf.percentageDetailLab.text = @"完成率";
            
        }else {
            weakSelf.percentageLab.text = [NSString stringWithFormat:@"%.1f%%",(_doing + _todo)/(_doing + _done +_todo) *100];
            if ((_doing + _done +_todo) == 0) {
                weakSelf.percentageLab.text = @"0";
            }
            weakSelf.percentageDetailLab.text = @"未完成率";
            
        }
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(pieIndexClick:)]) {
            [weakSelf.delegate pieIndexClick:index];
        }
    };
}


-(void)setdata{
    
    NSDictionary *dictionary = @{
                                  @"code":@"1",
                                  @"message": @"通过率",
                                  @"object" : @[
                                          @{
                                              @"num" : @"5",
                                              @"status" : @"Task-doing",
                                              },
                                          @{
                                              @"num" : @"3",
                                              @"status" : @"Task-done",
                                              },
                                          @{
                                              @"num" : @"4",
                                              @"status" :@"Task-todo",
                                              }
                                          ],
                                  };
    
    
    if (dictionary[@"object"]
        &&[dictionary[@"object"] isKindOfClass:[NSArray class]])
    {
        NSArray *objDict = dictionary[@"object"];
        _doing = 0.0;
        _done  = 0.0;
        _todo  = 0.0;
        _titleLab.text = @"概况";
        for (NSDictionary *dict in objDict) {
            if (dict
                &&[dict isKindOfClass:[NSDictionary class]])
            {
                
                if (dict[@"status"]
                    &&[[dict getSafeStringWithKey:@"status"]   isEqualToString:@"Task-doing"])
                {
                    _doing += [dict[@"num"] floatValue];
                }
                else if (dict[@"status"]
                         &&[[dict getSafeStringWithKey:@"status"]   isEqualToString:@"Task-done"])
                {
                    _done += [dict[@"num"] floatValue];
                }
                else if (dict[@"status"]
                         &&[[dict getSafeStringWithKey:@"status"]   isEqualToString:@"Task-todo"])
                {
                    _todo += [dict[@"num"] floatValue];
                }
            }
        }
        _totalLab.text = [NSString stringWithFormat:@"%.0f",_doing + _done +_todo];
        _unDoneLab.text = [NSString stringWithFormat:@"%.0f",_doing + _todo];
        _finishLab.text = [NSString stringWithFormat:@"%.0f",_done];
        _percentageLab.text = [NSString stringWithFormat:@"%.1f%%",(_done)/(_doing + _done +_todo) * 100];
        if ([_percentageLab.text containsString:@"nan"])
        {
            _percentageLab.text = @"";
        }
        
        
        EPDrawPieModel *model = [[EPDrawPieModel alloc] init];
        model.valueArray = [NSMutableArray arrayWithArray: @[@(_done),@(_doing + _todo)]];
        model.colorArray = [NSMutableArray arrayWithArray: @[COLOR_HEX(0x84d947),COLOR_HEX(0xfa8e4e)]];
        model.radius = (127.5 + 40 )/3;
        model.lineWidth = (194 - 127.5 + 25)/3;
        
        if (SCREEN_WIDTH <= 320) {
            model.radius = (127.5 )/3;
            model.lineWidth = (194 - 127.5 )/3;
        }
        
        [model setForFrame];
        
        self.drawPieView.model = model;
        _drawPieView.selectIndex = 0;
        
    }
    

}
@end

