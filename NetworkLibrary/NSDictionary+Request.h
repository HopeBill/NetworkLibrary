//
//  NSDictionary+Request.h
//  OneKeyBrother
//
//  Created by Bill on 9/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+Request.h"

@interface NSDictionary (Request)
/**
 将字典参数变字符串
 */
- (NSString *)ParamsStringSignature:(BOOL)isForSignature;
/**
 转义参数
 */
- (NSArray *)TransformedUrlParamsArraySignature:(BOOL)isForSignature;
@end
