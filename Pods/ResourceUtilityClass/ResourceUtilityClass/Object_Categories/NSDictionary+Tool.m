#import "NSDictionary+Tool.h"

@implementation NSDictionary (Tool)

- (id)objectForKeyNotNull:(id)aKey {
    id object = [self objectForKey:aKey];
    if (object == [NSNull null]) {
        object = nil;
    }
    
    return object;
}

- (id)objectForKeyNotNil:(id)aKey
{
    if (self == nil) {
        return nil;
    }
    
    id object = [self objectForKey:aKey];
    
    if (object == [NSNull null]) {
        object = nil;
    }
    
    return object;
}

- (id)strForKeyNotNilNull:(id)aKey
{
    if (self == nil) {
        return @"";
    }
    
    id object = [self objectForKey:aKey];
    
    if (object == nil) {
        return @"";
    }
    
    if (object == [NSNull null]) {
        object = @"";
    }
    
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    
    return [NSString stringWithFormat:@"%@", object];
}
- (NSString *)DictionaryToJSON{
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
