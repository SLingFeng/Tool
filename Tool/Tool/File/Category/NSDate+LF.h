//
//  NSDate+LF.h
//  Tool
//
//  Created by mac on 2021/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LF)
///距离今天多少天
+ (NSInteger)nowDayIn:(NSDate *)inDate;

///是否本周
+ (BOOL)getWeekBeginAndEndWith:(NSDate *)newDate;

+ (void)getMonthBeginAndEndWith:(NSDate *)newDate;

@end

NS_ASSUME_NONNULL_END
