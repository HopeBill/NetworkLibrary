//
//  NSErrorHelper.m
//  JianDan
//
//  Created by 刘献亭 on 15/10/15.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "NSErrorHelper.h"

NSString *const errorHelperDomain = @"http://NSErrorHelper";

@implementation NSErrorHelper

+ (NSString *)handleErrorMessage:(NSError *)error {
    NSString * result = nil;
    switch (error.code) {
        case customErrorCode://0 自定义错误
            result = error.userInfo[customErrorInfoKey];
            break;
        case kCFURLErrorTimedOut://-1001
            result = @"服务器连接超时";
            break;
        case 60://60 "Operation timed out"
            result = @"请求超时";
            break;
        case kCFURLErrorBadServerResponse://-1011
            result = @"请求无效";
            break;
        case kCFURLErrorNotConnectedToInternet: //-1009 @"似乎已断开与互联网的连接。"
        case kCFURLErrorCannotDecodeContentData://-1016 cmcc 解析数据失败
            result = @"网络好像断开了...";
            break;
        case kCFURLErrorCannotFindHost: //-1003 @"未能找到使用指定主机名的服务器。"
            result = @"服务器连接超时";
            break;
        case kCFURLErrorNetworkConnectionLost: //-1005
            result = @"网络连接已中断";
            break;
        default:
            result = @"请求失败";
            break;
    }
    return result;
}

+(NSString*)handleSuccessMessage:(NSDictionary*)dic{
    
    NSString * result = nil;
    NSString *codeType=[self filterStrObject:dic[@"code"]];
    switch ([codeType intValue]) {
        case 0:
            result =dic[@"message"];
            if ([dic[@"message"] length]>30) {
                return @"请求失败";
            }
            break;
        case 2:
            result = @"手机号码不存在";
            break;
        case 3://
            result = @"手机号码输入为空";
            break;
        case 4://-1011
            result = @"手机号或密码不匹配";
            break;
        case 5:
            result = @"手机号或密码不匹配";
            break;
        case 6://
            result = @"手机号不足11位";
            break;
        case 7: //
            result = @"验证码不正确";
            break;
        case 8:
            result = @"手机号没注册";
            break;
        case 9:
            result = @"密码不足6位";
            break;
        case 10:
            result = @"两次密码不一致";
            break;
        case 11:
            result = @"验证码错误或已失效";
            break;
        case 12:
            result = @"短信验证码获取频繁，请明天再试！";
            break;
        default:
            result =dic[@"message"];
            if ([dic[@"message"] length]>30) {
                return @"请求失败";
            }
            break;
    }
    return result;
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
+ (NSError *)createErrorWithErrorInfo:(NSString *)customErrorInfo {
    return [NSError errorWithDomain:errorHelperDomain code:customErrorCode userInfo:@{customErrorInfoKey : customErrorInfo}];
}

+ (NSError *)createErrorWithErrorInfo:(NSString *)customErrorInfo domain:(NSString *)domain {
    return [NSError errorWithDomain:domain code:customErrorCode userInfo:@{customErrorInfoKey : customErrorInfo}];
}

+ (NSError *)createErrorWithErrorInfo:(NSString *)customErrorInfo domain:(NSString *)domain code:(NSInteger)code {
    return [NSError errorWithDomain:domain code:code userInfo:@{customErrorInfoKey : customErrorInfo}];
}

+ (NSError *)createErrorWithDomain:(NSString *)domain code:(NSInteger)code {
    return [NSError errorWithDomain:domain code:code userInfo:nil];
}

+ (NSError *)createErrorWithUserInfo:(NSDictionary *)userInfo {
    return [NSError errorWithDomain:errorHelperDomain code:customErrorCode userInfo:userInfo];
}

+ (NSError *)createErrorWithUserInfo:(NSDictionary *)userInfo domain:(NSString *)domain {
    return [NSError errorWithDomain:domain code:customErrorCode userInfo:userInfo];
}

+ (NSError *)createErrorWithUserInfo:(NSDictionary *)userInfo domain:(NSString *)domain code:(NSInteger)code {
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

@end
