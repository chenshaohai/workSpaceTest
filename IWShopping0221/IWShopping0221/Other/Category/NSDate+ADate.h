//
//  NSDate+ADate.h
//  AvenueMobile
//
//  Created by admin-LI on 16/8/26.
//  Copyright © 2016年 华为科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ADate)

- (NSUInteger)daysAgo;
- (NSUInteger)daysAgoAgainstMidnight;
- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
- (NSUInteger)weekday;

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime;

- (NSString *)string;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSDate *)beginningOfWeek;
- (NSDate *)beginningOfDay;
- (NSDate *)endOfWeek;

+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;

+ (NSDate*)yesterday;

# pragma mark  获取当前时区当前日期字符串yyyy-MM-dd
/**
 *  获取当前时区当前日期字符串yyyy-MM-dd
 */
+(NSString *)getCurrentDateString;

# pragma mark  获取指定天数前日期字符串yyyy-MM-dd
/**
 *  获取指定天数前日期字符串yyyy-MM-dd
 */
+(NSString *)getDateStringLateDays:(int)day;


# pragma mark  获取当前时区当前时间小时字符串 HH
/**
 *  获取当前时区当前时间小时字符串 HH
 */
+(NSString *)getCurrentHourString;

# pragma mark  获取HHmmssString
/**
 *  获取HHmmssString
 */
+(NSString *)getHHmmSSStringWithDate:(NSDate *)date;


# pragma mark 返回当前时区当前日期
/*
 *  返回当前时区当前日期
 */
+(NSDate *)getLocaleDate;
# pragma mark  获取当前时区当前日期字符串MM-dd
/**
 *  获取当前时区当前日期字符串MM-dd
 */
+(NSString *)getCurrentDateMMddString;
# pragma mark  获取指定天数前日期字符串MM-dd
/**
 *  获取指定天数前日期字符串MM-dd
 */
+(NSString *)getDateMMddStringLateDays:(int)day;

# pragma mark  NSDate 返回 yyyy-MM-dd
/**
 *   date
 *   return       yyyy-MM-dd
 */
+(NSString *)dateToyyyyMMddString:(NSDate *)date;

# pragma mark  传入整数 返回 yyyy-MM-dd
/**
 *   dateInteger  必须是13位整数
 *   return       yyyy-MM-dd HH:mm:ss
 */
+(NSString *)dateToyyyyMMddStringWithInteger:(double)dateInteger;


# pragma mark  传入double 返回 yyyy-MM-dd HH:mm:ss
/**
 *   dateInteger  必须是double
 *   return       yyyy-MM-dd HH:mm:ss
 */
+(NSString *)dateToyyyyMMddHHmmssStringWithInteger:(double)dateInteger;
# pragma mark  传入double 返回 NSDate
/**
 *   dateInteger  必须是double
 *   return      NSDate
 */
+(NSDate *)dateWithInteger:(double)dateInteger;
# pragma mark  传入yyyy-MM-dd HH:mm:ss 返回 整数
/**
 *   dateString  yyyy-MM-dd HH:mm:ss
 *   return        double
 */
+(double)dateStringyyyyMMddHHmmssToInteger:(NSString *)dateString;
# pragma mark  传入 NSDate 返回 整数
/**
 *   date
 *   return      double
 */
+(double)dateToInteger:(NSDate *)date;
@end
