//
//  NSDate+TimeInterVal.h
//  OneKeyBrother
//
//  Created by Bill on 17/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (TimeInterVal)
+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format;
+(NSString *)getCurrentDateWithFormat:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
