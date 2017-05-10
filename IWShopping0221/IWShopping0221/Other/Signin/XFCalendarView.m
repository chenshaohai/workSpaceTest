//
//  XFCalendarItem.m
//  Calendar
//
//  Created by XiaoFeng on 2016/11/22.
//  Copyright © 2016年 XiaoFeng. All rights reserved.
//

#import "XFCalendarView.h"

@interface XFCalendarView ()
@property (nonatomic,weak)UIView *weekBg;
// 判断是否点击非今天日期
@property (nonatomic,assign)NSInteger isOtherDay;
@end

@implementation XFCalendarView
{
    UIButton  *_selectButton;
    NSMutableArray *_daysArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _daysArray = [NSMutableArray arrayWithCapacity:42];
        for (int i = 0; i < 42; i++) {
            UIButton *button = [[UIButton alloc] init];
            [self addSubview:button];
            [_daysArray addObject:button];
        }
    }
    return self;
}

#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    
    [self createCalendarViewWith:date];
    
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    CGFloat itemW     = self.frame.size.width / 7;
    CGFloat itemH     = self.frame.size.width / 7;
    
    // 1.year month
    //    UILabel *headlabel = [[UILabel alloc] init];
    //    headlabel.text     = [NSString stringWithFormat:@"%li-%li",[XFCalendarTool year:date],[XFCalendarTool month:date]];
    //    headlabel.font     = [UIFont systemFontOfSize:14];
    //    headlabel.frame           = CGRectMake(0, 0, self.frame.size.width, itemH);
    //    headlabel.textAlignment   = NSTextAlignmentCenter;
    //    [self addSubview:headlabel];
    
    // 2.weekday
    ////1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    [self.weekBg removeFromSuperview];
    UIView *weekBg = [[UIView alloc] init];
    weekBg.frame = CGRectMake(0, 0, self.frame.size.width, kFRate(50));
    self.weekBg = weekBg;
    [self addSubview:weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = kFont24px;
        week.frame    = CGRectMake(itemW * i, kFRate(25), itemW, kFRate(17));
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = IWColor(152, 152, 152);
        [weekBg addSubview:week];
    }
    
    // 今天日期
    // 获取系统时间
    NSDate *sendDate = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *conponent = [cal components:unitFlags fromDate:sendDate];
    _todayNum = [conponent day];
    
    NSNumber *todayNum = [NSNumber numberWithInteger:_todayNum];
    if (![_signArray containsObject:todayNum]) {
        _isToday = NO;
    }else {
        _isToday = YES;
    }
    
    //  3.days (1-31)
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH + CGRectGetMaxY(weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x, y, itemW, itemH);
        dayButton.titleLabel.font = kFont24px;
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        dayButton.tag = i;
        
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger daysInLastMonth = [XFCalendarTool totaldaysInMonth:[XFCalendarTool lastMonth:date]];
        NSInteger daysInThisMonth = [XFCalendarTool totaldaysInMonth:date];
        NSInteger firstWeekday    = [XFCalendarTool firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        
        //设置不是本月的日期字体颜色   ---白色  看不到
        if (i < firstWeekday) {
            
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            //这个月 今日之后的日期style
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
        // this month
        if ([XFCalendarTool month:date] == [XFCalendarTool month:[NSDate date]]) {
            
            NSInteger todayIndex = [XFCalendarTool day:date] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
                //这个月 今日之前的日期style
                [self setStyle_BeforeToday:dayButton];
                [self setSign:i - (int)firstWeekday + 1 andBtn:dayButton];
                
            }else if(i == todayIndex){
                // 今天
                if (!_isToday) {
                    [self setStyle_Today:dayButton];
                }else{
                    [self setSign:i - (int)firstWeekday + 1 andBtn:dayButton];
                }
                _dayButton = dayButton;
            }
        }
    }
}


#pragma mark 设置已经签到
- (void)setSign:(int)i andBtn:(UIButton*)dayButton{
    [_signArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int now = i;
        int now2 = [obj intValue];
        if (now2 == now) {
            [self setStyle_SignEd:dayButton];
        }
    }];
}


#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn
{
    _selectButton.selected = NO;
    
    dayBtn.selected = YES;
    _selectButton = dayBtn;
    
    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
    
    if (day == _todayNum) {
        _isOtherDay = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IWHomeSignToday" object:nil userInfo:@{@"todayBtn":[NSNumber numberWithInteger:day]}];
        [_dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_dayButton setBackgroundImage:_IMG(@"IWHomeSignS") forState:UIControlStateNormal];
    }else{
        _isOtherDay = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IWHomeSignDay" object:nil userInfo:@{@"otherDayBtn":[NSNumber numberWithInteger:day]}];
        if (_isToday == NO) {
            [_dayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [_dayButton setTitleColor:[UIColor HexColorToRedGreenBlue:@"#ed766d"] forState:UIControlStateNormal];
        }
        [_dayButton setBackgroundImage:_IMG(@"IWHomeSignW") forState:UIControlStateNormal];
    }
}


#pragma mark - date button style
//设置不是本月的日期字体颜色   ---白色  看不到
- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

//这个月 今日之前的日期style
- (void)setStyle_BeforeToday:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:IWColor(172, 172, 172) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundImage:_IMG(@"IWHomeSignW") forState:UIControlStateNormal];
    [btn setBackgroundImage:_IMG(@"IWHomeSignS") forState:UIControlStateSelected];
}


//今日已签到
- (void)setStyle_Today_Signed:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor HexColorToRedGreenBlue:@"#ed766d"] forState:UIControlStateNormal];
}

//今日没签到
- (void)setStyle_Today:(UIButton *)btn
{
    btn.enabled = YES;
    if (_isOtherDay) {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:_IMG(@"IWHomeSignW") forState:UIControlStateNormal];
    }else{
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:_IMG(@"IWHomeSignS") forState:UIControlStateNormal];
    }
}

//这个月 今天之后的日期style
- (void)setStyle_AfterToday:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


//已经签过的 日期style
- (void)setStyle_SignEd:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor HexColorToRedGreenBlue:@"#ed766d"] forState:UIControlStateNormal];
    [btn setBackgroundImage:_IMG(@"IWHomeSignW") forState:UIControlStateNormal];
}

@end
