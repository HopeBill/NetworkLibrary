
//
//  NSDate+TimeInterVal.m
//  OneKeyBrother
//
//  Created by Bill on 17/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import "NSDate+TimeInterVal.h"

@implementation NSDate (TimeInterVal)
+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:datestr];
#if ! __has_feature(objc_arc)
    [dateFormatter release];
#endif
    return date;
}
+(NSString *)getCurrentDateWithFormat:(NSString *)format{
    
    
    /*给NSDate设置时区*/
    NSDate *date = [NSDate date]; //[NSDate date]获取的时间是标注的UTC时间,和北京时间相差8小时
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得当前的时区
    //    NSTimeInterval interval  = [zone secondsFromGMTForDate:date];
    
    //    NSDate *dateNow = [date dateByAddingTimeInterval:interval];// 加上差的时间
    
    //给NSDateFormatter设置时区
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setTimeZone:[NSTimeZone localTimeZone]];
    [forMatter setDateFormat:format];
    
    NSString *dateStr = [forMatter stringFromDate:date];
    
    return dateStr;
}
@end
