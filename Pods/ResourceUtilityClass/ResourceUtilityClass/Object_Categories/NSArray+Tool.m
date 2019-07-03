
//
//  NSArray+Tool.m
//  OneKeyBrother
//
//  Created by Bill on 6/5/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import "NSArray+Tool.h"

@implementation NSArray (Tool)
/** 数组变json */
- (NSString *)ArrayJsonString{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:0];
}
- (NSString *)ArrayToJSON{
    NSData *data=[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:0];
    
    //去除空格和回车：
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSLog(@"jsonStr==%@",jsonStr);
    return jsonStr;
}
@end
