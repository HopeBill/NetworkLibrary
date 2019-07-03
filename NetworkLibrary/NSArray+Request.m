
//
//  NSArray+Request.m
//  OneKeyBrother
//
//  Created by Bill on 9/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import "NSArray+Request.h"

@implementation NSArray (Request)
/** 字母排序之后形成的参数字符串 */
- (NSString *)ParamsString
{
    NSMutableString *paramString = [[NSMutableString alloc] init];
    
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([paramString length] == 0) {
            [paramString appendFormat:@"%@", obj];
        } else {
            [paramString appendFormat:@"&%@", obj];
        }
    }];
    
    return paramString;
}
@end
