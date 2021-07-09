//
//  NSDate+LF.m
//  Tool
//
//  Created by mac on 2021/7/9.
//

#import "NSDate+LF.h"

@implementation NSDate (LF)

+ (NSInteger)nowDayIn:(NSDate *)inDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [NSDate date];
    NSDate *endDate = inDate;
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    //打印
    NSLog(@"%@",delta);
    //获取其中的"天"
    NSLog(@"%ld",delta.day);
    return abs(delta.day);
}

+ (BOOL)getWeekBeginAndEndWith:(NSDate *)newDate {

    NSDate *nowDate = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];

    // 获取今天是周几

    NSInteger weekDay = [comp weekday];

    /**获取当前几个月*/

    NSInteger monthDay = [comp month];

    NSLog(@"%ld",monthDay);

    // 获取几天是几号

    NSInteger day = [comp day];

    NSLog(@"%ld----%ld",weekDay,day);

    // 计算当前日期和本周的星期一和星期天相差天数

    long firstDiff,lastDiff;

    //    weekDay = 1;

    if (weekDay == 1)

    {

        firstDiff = -6;

        lastDiff = 0;

    }

    else

    {

        firstDiff = [calendar firstWeekday] - weekDay + 1;

        lastDiff = 8 - weekDay;

    }

    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);

    

    // 在当前日期(去掉时分秒)基础上加上差的天数

    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];

    [firstDayComp setDay:day + firstDiff];

    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];

    

    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];

    [lastDayComp setDay:day + lastDiff];

    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];

    

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"MM月dd日"];

    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];

    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];

    NSLog(@"%@=======%@",firstDay,lastDay);

    

    NSString *dateStr = [NSString stringWithFormat:@"%@-%@",firstDay,lastDay];

    NSDateComponents *inTime = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:newDate];
    BOOL inWeek;
    if ([inTime month] >= [firstDayComp month] &&
        [inTime month] <= [lastDayComp month]) {
        if ([inTime day] >= [firstDayComp day] &&
            [inTime day] <= [lastDayComp day]) {
            inWeek = YES;
        }
    }

    NSLog(@"%@",dateStr);

    return inWeek;
}

 

+ (void)getMonthBeginAndEndWith:(NSDate *)newDate{

    if (newDate == nil) {

        newDate = [NSDate date];

        

    }

    double interval = 0;

    NSDate *beginDate = nil;

    NSDate *endDate = nil;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar setFirstWeekday:2];

    //设定周一为周首日

    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate]; //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit

    if (ok) {

        endDate = [beginDate dateByAddingTimeInterval:interval-1];

        

    }else {

        return;

        

    }

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];

    [myDateFormatter setDateFormat:@"yyyy.MM.dd"];

    NSString *beginString = [myDateFormatter stringFromDate:beginDate];

    NSString *endString = [myDateFormatter stringFromDate:endDate];

    NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];

    NSLog(@"%@",s);

}

@end
