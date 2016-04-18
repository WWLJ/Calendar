//
//  NSDate+Helper.h
//  CustomCalendar
//
//  Created by YiTie on 16/3/29.
//  Copyright © 2016年 武文杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

#pragma mark - date

/**
 *  当前是哪一天
 *
 *  @param date 日期
 *
 *  @return 几号
 */
- (NSInteger)day;

/**
 *  当前是那一月
 *
 *  @param date 日期
 *
 *  @return 那一月
 */
- (NSInteger)month;

/**
 *  当前是哪一年
 *
 *  @param date 日期
 *
 *  @return 哪一年
 */
- (NSInteger)year;

/**
 *  当前月第一天是周几
 *
 *  @param date 日期
 *
 *  @return 返回星期几
 */
- (NSInteger)firstWeekdayInThisMonth;


/**
 *  这个月总共多少天
 *
 *  @param date 日期
 *
 *  @return 返回天数
 */
- (NSInteger)totaldaysInThisMonth;


/**
 *  上个月的date
 *
 *  @param date 当前日期
 *
 *  @return 上个月的日期
 */
- (NSDate *)lastMonth;


/**
 *  下个月的date
 *
 *  @param date 日期
 *
 *  @return 下个月的日期
 */
- (NSDate*)nextMonth;



///判断日期是今天,明天,后天,周几
-(NSString *)compareIfTodayWithDate;







@end
