//
//  NSString+YJExpansion.m
//  Gifts
//
//  Created by yjadair on 15/11/27.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "NSString+YJExpansion.h"

@implementation NSString (YJExpansion)

+ (NSString*)weekdayStringFromDate:(NSString *)dateString{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM月dd日 ";
    NSTimeInterval time = dateString.longLongValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *dates = [formatter stringFromDate:date];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
   
    
    return [dates stringByAppendingString: weekdays[theComponents.weekday]];
    
}
@end
