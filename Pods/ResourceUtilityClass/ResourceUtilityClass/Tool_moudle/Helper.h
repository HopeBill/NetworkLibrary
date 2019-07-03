//
//  Helper.h
//  zmu
//
//  Created by lee on 2017/9/25.
//  Copyright © 2017年 Libiyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject
+(instancetype)shareManager;
/**
 *手机号码验证
 **/
+ (BOOL)justMobile:(NSString *)mobile;
/**
 *密码
 **/
+ (BOOL) justPassword:(NSString *)passWord;
/**
 *填写名字规则
 **/
+(BOOL)justName:(NSString*)str;
/**
 *过滤字符串空值
 **/
+(NSString*)filterStrObject:(id)data;
/**
 *过滤字典空值
 **/
+(NSDictionary*)filterDicObject:(id)data;
/**
 *过滤NSNumber 空值
 **/
+(NSNumber*)filterNumObject:(id)data;
/**
 *过滤数组 空值
 **/
+(NSArray*)filterArrObject:(id)data;
/**
 *获取当天结束时间
 **/
+(NSString*)getCurrentEndTime;
/**
 *获取当前标准时间
 **/
+ (NSString *)getCurrentTime;
/**
 *获取当前当前时间
 **/
+ (NSString *)getCurrentTime:(NSString*)str;
/**
 *获取标准时间的时间戳yyyy-MM-dd HH:mm:ss
 **/
+ (NSTimeInterval)getCurrentTimestamp:(NSString*)time;
/**
 *获取非标准时间戳HH:mm:ss
 **/
+ (NSTimeInterval)getNoStandardTimestamp:(NSString*)time;
/**
 *将时间戳转化为标准时间
 **/
+(NSString*)timestampChangesStandarTime:(NSTimeInterval)time;
/**
 时间戳相减
 */

+(NSTimeInterval)timertampSubtractionStartTime:(NSTimeInterval)serverTime withEndTime:(NSTimeInterval)endTime;
/**
 *获取当前启动时间，即：kernel_task运行时间
 **/
+(time_t)uptime;
@end
