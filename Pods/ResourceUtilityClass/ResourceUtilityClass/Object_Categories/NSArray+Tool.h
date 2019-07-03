//
//  NSArray+Tool.h
//  OneKeyBrother
//
//  Created by Bill on 6/5/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Tool)
/**
 *数组变json
 */
- (NSString *)ArrayJsonString;
/**
 *数组变json
 */
- (NSString *)ArrayToJSON;
@end

NS_ASSUME_NONNULL_END
