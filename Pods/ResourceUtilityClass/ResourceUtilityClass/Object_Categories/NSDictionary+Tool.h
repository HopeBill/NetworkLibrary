
#import <Foundation/Foundation.h>

@interface NSDictionary (Tool)

/** 如果是NULL的对象,返回nil */
- (id)objectForKeyNotNull:(id)aKey;

- (id)objectForKeyNotNil:(id)aKey;

- (id)strForKeyNotNilNull:(id)aKey;

/**
 *数组变json
 */
- (NSString *)DictionaryToJSON;

@end
