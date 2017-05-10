//
//  NSDate+ADate.m
//  AvenueMobile
//
//  Created by admin-LI on 16/8/26.
//  Copyright © 2016年 华为科技有限公司. All rights reserved.
//

#import "NSDate+ADate.h"
@implementation NSDate (ADate)

/*
 * This guy can be a little unreliable and produce unexpected results,
 * you're better off using daysAgoAgainstMidnight
 */
- (NSUInteger)daysAgo {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}

- (NSUInteger)daysAgoAgainstMidnight {
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
    return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
    NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = @"Today";
            break;
        case 1:
            text = @"Yesterday";
            break;
        default:
            text = [NSString stringWithFormat:@"%ld days ago", (long)daysAgo];
    }
    return text;
}

- (NSUInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];
    return [weekdayComponents weekday];
}

+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    
    return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime {
    /*
     * if the date is in today, display 12-hour time with meridian,
     * if it is within the last 7 days, display weekday name (Friday)
     * if within the calendar year, display as Jan 23
     * else display as Nov 11, 2008
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    
    NSDate *today = [NSDate date];
    NSDateComponents *offsetComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                     fromDate:today];
    
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    NSString *displayString = nil;
    
    // comparing against midnight
    NSComparisonResult midnight_result = [date compare:midnight];
    if (midnight_result == NSOrderedDescending) {
        if (prefixed) {
            [displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
        } else {
            [displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
        }
    } else {
        // check if date is within last 7 days
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-7];
        NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        NSComparisonResult lastweek_result = [date compare:lastweek];
        if (lastweek_result == NSOrderedDescending) {
            if (displayTime) {
                [displayFormatter setDateFormat:@"EEEE h:mm a"];
            } else {
                [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
            }
        } else {
            // check if same calendar year
            NSInteger thisYear = [offsetComponents year];
            
            NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                           fromDate:date];
            NSInteger thatYear = [dateComponents year];
            if (thatYear >= thisYear) {
                if (displayTime) {
                    [displayFormatter setDateFormat:@"MMM d h:mm a"];
                }
                else {
                    [displayFormatter setDateFormat:@"MMM d"];
                }
            } else {
                if (displayTime) {
                    [displayFormatter setDateFormat:@"MMM d, yyyy h:mm a"];
                }
                else {
                    [displayFormatter setDateFormat:@"MMM d, yyyy"];
                }
            }
        }
        if (prefixed) {
            NSString *dateFormat = [displayFormatter dateFormat];
            NSString *prefix = @"'on' ";
            [displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
        }
    }
    
    // use display formatter to return formatted date string
    displayString = [displayFormatter stringFromDate:date];
    
    
    return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
    return [[self class] stringForDisplayFromDate:date prefixed:prefixed alwaysDisplayTime:NO];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
    return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    //获取时区
    //    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    //    //设定时区
    //    [outputFormatter setTimeZone:timeZone];
    
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

- (NSString *)string {
    return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}

- (NSDate *)beginningOfWeek {
    // largely borrowed from "Date and Time Programming Guide for Cocoa"
    // we'll use the default calendar and hope for the best
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginningOfWeek = nil;
    BOOL ok = [calendar rangeOfUnit:kCFCalendarUnitWeek startDate:&beginningOfWeek
                           interval:NULL forDate:self];
    if (ok) {
        return beginningOfWeek;
    }
    
    // couldn't calc via range, so try to grab Sunday, assuming gregorian style
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    beginningOfWeek = nil;
    beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    //normalize to midnight, extract the year, month, and day components and create a new date from those components.
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                               fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}

- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return endOfWeek;
}

+ (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
    return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
    return @"yyyy-MM-dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)dbFormatString {
    return [NSDate timestampFormatString];
}

+ (NSDate*)yesterday
{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    //昨天时间
    NSDate *yesterday = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    return yesterday;
}

# pragma mark  获取当前时区当前日期字符串yyyy-MM-dd
/**
 *  获取当前时区当前日期字符串yyyy-MM-dd
 */
+(NSString *)getCurrentDateString
{
    //   这样取没有问题， 反而取当前时区时间有问题
    NSDate * date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}

# pragma mark  获取当前时区当前日期字符串MM-dd
/**
 *  获取当前时区当前日期字符串MM-dd
 */
+(NSString *)getCurrentDateMMddString
{
    //   这样取没有问题， 反而取当前时区时间有问题
    NSDate * date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

# pragma mark  获取HHmmssString
/**
 *  获取HHmmssString
 */
+(NSString *)getHHmmSSStringWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

# pragma mark  获取当前时区当前时间小时字符串 HH
/**
 *  获取当前时区当前时间小时字符串 HH
 */
+(NSString *)getCurrentHourString
{
    //   这样取没有问题， 反而取当前时区时间有问题
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *hourString = [formatter stringFromDate:date];
    return hourString;
}


# pragma mark  获取指定天数前日期字符串yyyy-MM-dd
/**
 *  获取指定天数前日期字符串yyyy-MM-dd
 */
+(NSString *)getDateStringLateDays:(int)day{
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval second = day * 24 * 60 * 60.0f;	//
    NSDate *laterDay =[currentDate dateByAddingTimeInterval:-second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *laterDateString = [formatter stringFromDate:laterDay];
    return laterDateString;
}

# pragma mark  获取指定天数前日期字符串MM/dd
/**
 *  获取指定天数前日期字符串MM/dd
 */
+(NSString *)getDateMMddStringLateDays:(int)day{
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval second = day * 24 * 60 * 60.0f;	//
    NSDate *laterDay =[currentDate dateByAddingTimeInterval:-second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    NSString *laterDateString = [formatter stringFromDate:laterDay];
    return laterDateString;
}

# pragma mark  获取指定天数前日期字符串MM-dd
/**
 *  获取指定天数前日期字符串MM-dd
 */
+(NSString *)getDateMMHddStringLateDays:(int)day{
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval second = day * 24 * 60 * 60.0f;	//
    NSDate *laterDay =[currentDate dateByAddingTimeInterval:-second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *laterDateString = [formatter stringFromDate:laterDay];
    return laterDateString;
}


# pragma mark 返回当前时区当前日期
/*
 *  返回当前时区当前日期
 */
+(NSDate *)getLocaleDate
{
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    return  [date  dateByAddingTimeInterval: interval];
}
//给定date   返回年月日时分秒
+(void)inputDate:(NSDate*)date returnString:(void (^)(NSString *year,NSString *month,NSString *day,NSString *hour,NSString *minute,NSString *second))success{

    NSDateFormatter *formatterYear = [[NSDateFormatter alloc] init];
    [formatterYear setDateFormat:@"yyyy"];
    NSString *year = [formatterYear stringFromDate:date];
    
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
    [formatterMonth setDateFormat:@"MM"];
    NSString *month = [formatterMonth stringFromDate:date];
    
    NSDateFormatter *formatterDay = [[NSDateFormatter alloc] init];
    [formatterDay setDateFormat:@"dd"];
    NSString *day = [formatterDay stringFromDate:date];
    
    NSDateFormatter *formatterHour = [[NSDateFormatter alloc] init];
    [formatterHour setDateFormat:@"HH"];
    NSString *hour = [formatterHour stringFromDate:date];
    
    NSDateFormatter *formatterMinute = [[NSDateFormatter alloc] init];
    [formatterMinute setDateFormat:@"mm"];
    NSString *minute = [formatterMinute stringFromDate:date];
    
    NSDateFormatter *formatterSecond = [[NSDateFormatter alloc] init];
    [formatterSecond setDateFormat:@"ss"];
    NSString *second = [formatterSecond stringFromDate:date];
    
    if (success) {
        success(year,month,day,hour,minute,second);
    }
}

# pragma mark  NSDate 返回 yyyy-MM-dd
/**
 *   date
 *   return       yyyy-MM-dd
 */
+(NSString *)dateToyyyyMMddString:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

# pragma mark  传入整数 返回 yyyy-MM-dd
/**
 *   dateInteger  必须是13位整数
 *   return       yyyy-MM-dd HH:mm:ss
 */
+(NSString *)dateToyyyyMMddStringWithInteger:(double)dateInteger{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:dateInteger/1000];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

# pragma mark  传入整数 返回 yyyy-MM-dd HH:mm:ss
/**
 *   dateInteger  必须是13位整数
 *   return       yyyy-MM-dd HH:mm:ss
 */
+(NSString *)dateToyyyyMMddHHmmssStringWithInteger:(double)dateInteger{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:dateInteger/1000];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
# pragma mark  传入double 返回 NSDate
/**
 *   dateInteger  必须是13位整数
 *   return      NSDate
 */
+(NSDate *)dateWithInteger:(double)dateInteger{
   NSDate* date = [NSDate dateWithTimeIntervalSince1970:dateInteger/1000];
    return date;
}

# pragma mark  传入yyyy-MM-dd HH:mm:ss 返回 整数
/**
 *   dateString  yyyy-MM-dd HH:mm:ss
 *   return        double
 */
+(double)dateStringyyyyMMddHHmmssToInteger:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date =[formatter dateFromString:dateString];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval;
}
# pragma mark  传入 NSDate 返回 整数
/**
 *   date
 *   return      double
 */
+(double)dateToInteger:(NSDate *)date{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval;
}
@end
