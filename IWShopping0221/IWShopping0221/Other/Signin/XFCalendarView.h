//
//  MyCalendarItem.h
//  HYCalendar
//
//  Created by nathan on 14-9-17.
//  Copyright (c) 2014年 nathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFCalendarTool.h"

@interface XFCalendarView : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);

@property (nonatomic,strong)  NSMutableArray *signArray;

//今天
@property (nonatomic,strong)  UIButton *dayButton;
@property (nonatomic,assign)NSInteger todayNum;
// 今天是否签到
@property (nonatomic,assign) BOOL isToday;


- (void)setStyle_Today_Signed:(UIButton *)btn;
- (void)setStyle_Today:(UIButton *)btn;
- (void)setStyle_SignEd:(UIButton *)btn;
- (void)setStyle_BeforeToday:(UIButton *)btn;
@end
