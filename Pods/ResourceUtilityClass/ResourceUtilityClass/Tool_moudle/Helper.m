//
//  Helper.m
//  zmu
//
//  Created by lee on 2017/9/25.
//  Copyright © 2017年 Libiyong. All rights reserved.
//

#import "Helper.h"
#import <sys/sysctl.h>
@interface Helper ()
@property(nonatomic,strong)NSDateFormatter* formater;
@end

@implementation Helper
+(instancetype)shareManager{
    static Helper *userModel=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel=[[Helper alloc] init];
    });
    return userModel;
}
//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
#pragma 正则匹配用户密码6-16位数字和字母组合
+ (BOOL) justPassword:(NSString *)passWord
{
    //    (?=^.{8,}$)(?=.*\d)(?=.*\W+)(?=.*[A-Z])(?=.*[a-z])(?!.*\n).*$
    //
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![%&'.~!@,;{}、|*^%#=?$\x22]+$)[a-zA-Z0-9%&'.~!@,;{}、|*^%#=?$\x22]{6,16}";
    //    NSString *pattern = @"[0-9a-zA-Z]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:passWord];
    return isMatch;
}
#pragma mark===  填写名字规则
+(BOOL)justName:(NSString*)str{
    //    (?=^.{8,}$)(?=.*\d)(?=.*\W+)(?=.*[A-Z])(?=.*[a-z])(?!.*\n).*$
    //
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![%&'.~!@,;{}、|*^%#=?$\x22]+$)[a-zA-Z0-9%&'.~!@,;{}、|*^%#=?$\x22]{4,16}";
    //    NSString *pattern = @"[0-9a-zA-Z]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
#pragma mark===  过滤字符串空值
+(NSString*)filterStrObject:(id)data{
    if ([data isEqual:[NSNull null]]) {
        return @"";
    }else if ([data isKindOfClass:[NSNull class]]){
        return @"";
    }else if (data==nil){
        return @"";
    }else{
        return data;
    }
}
#pragma mark===  过滤字典空值
+(NSDictionary*)filterDicObject:(id)data{
    
    if ([data isEqual:[NSNull null]]) {
        return @{};
    }else if ([data isKindOfClass:[NSNull class]]){
        return @{};
    }else if (data==nil){
        return @{};
    }else{
        return data;
    }
}
#pragma mark=== 过滤数组 空值
+(NSArray*)filterArrObject:(id)data{
 
    if ([data isEqual:[NSNull null]]) {
        return @[];
    }else if ([data isKindOfClass:[NSNull class]]){
        return @[];
    }else if (data==nil){
        return @[];
    }else{
        return data;
    }
}
#pragma mark===  过滤NSNumber 空值
+(NSNumber*)filterNumObject:(id)data{
    
    if ([data isEqual:[NSNull null]]) {
        return @(-CGFLOAT_MAX);
    }else if ([data isKindOfClass:[NSNull class]]){
        return @(-CGFLOAT_MAX);
    }else if (data==nil){
        return @(-CGFLOAT_MAX);
    }else{
        return data;
    }
    
}
+(NSString*)getCurrentEndTime{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *components=[[NSDateComponents alloc] init];
    components.day=1;
    components.second=-1;
    NSDate*  nowDate  = [NSDate date];
    NSDate *startOfToday = [[NSCalendar currentCalendar] startOfDayForDate:nowDate];

  NSDate *endDate=[calendar dateByAddingComponents:components toDate:startOfToday options:0];
    [[Helper shareManager].formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [[Helper shareManager].formater setTimeZone:timeZone];
    NSString *endStr = [[Helper shareManager].formater stringFromDate:endDate];
    return endStr;
}
+ (NSString *)getCurrentTime{
    [[Helper shareManager].formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [[Helper shareManager].formater setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    NSString *currentDate = [[Helper shareManager].formater stringFromDate:datenow];
    return currentDate;
}
/**
 *获取当前当前时间
 **/
+ (NSString *)getCurrentTime:(NSString*)str{
    [[Helper shareManager].formater setDateFormat:str]; // ----------
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [[Helper shareManager].formater setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    NSString *currentDate = [[Helper shareManager].formater stringFromDate:datenow];
    return currentDate;
}

/**
 *获取标准时间的时间戳yyyy-MM-dd HH:mm:ss
 **/
+ (NSTimeInterval)getCurrentTimestamp:(NSString*)time{
    [[Helper shareManager].formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [[Helper shareManager].formater setTimeZone:timeZone];
    NSDate *date1=[ [Helper shareManager].formater dateFromString:time];
    NSTimeInterval a=[date1 timeIntervalSince1970];
    return a;
}
/**
 *获取非标准时间戳HH:mm:ss
 **/
+ (NSTimeInterval)getNoStandardTimestamp:(NSString *)time{
    
    NSArray *arr=[time componentsSeparatedByString:@":"];
    NSInteger hour=0;
    NSInteger minutes=0;
    NSInteger seconds=0;
    
    for (int i=0;i<arr.count;i++) {
        hour=[arr[0] integerValue]*3600;
        minutes=[arr[1] integerValue]*60;
        seconds=[arr[2] integerValue];
    }
    return hour+minutes+seconds;
}
/**
 *将时间戳转化为标准时间
 **/
+(NSString*)timestampChangesStandarTime:(NSTimeInterval)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    [[Helper shareManager].formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [[Helper shareManager].formater setTimeZone:timeZone];
    return [[Helper shareManager].formater stringFromDate: date];
}
/**
 时间戳相减
 */

+(NSTimeInterval)timertampSubtractionStartTime:(NSTimeInterval)serverTime withEndTime:(NSTimeInterval)endTime{
    [[Helper shareManager].formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [[Helper shareManager].formater setTimeZone:timeZone];
    //将时间戳转化为标准时间
    NSString *startTimer=[self timestampChangesStandarTime:serverTime];
    NSString *endTimer=[self timestampChangesStandarTime:endTime];
    NSDate *date1=[[Helper shareManager].formater dateFromString:startTimer];
    NSDate *date2=[[Helper shareManager].formater dateFromString:endTimer];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    return time;
}
/**
 *获取当前启动时间，即：kernel_task运行时间
 **/
+(time_t)uptime
{
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    time_t now;
    time_t uptime = -1;
    
    (void)time(&now);
    
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0)
    {
        uptime = now - boottime.tv_sec;
    }
    return uptime;
}
-(NSDateFormatter*)formater{
    if (!_formater) {
        _formater=[[NSDateFormatter alloc] init];
    }
    return _formater;
}
@end
