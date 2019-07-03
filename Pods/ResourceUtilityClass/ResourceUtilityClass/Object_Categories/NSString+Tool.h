//
//  NSString+Tool.h
//  OneKeyBrother
//
//  Created by Bill on 28/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Tool)

/**
 *获取字符串的宽度
 **/
-(CGFloat)widthOfStringFont:(UIFont *)font height:(CGFloat)height;
/**
 *获取字符串的高度
 **/
-(CGFloat)heightOfStringFont:(UIFont *)font withWidth:(CGFloat)width;
/**
 *计算富文本的高度
 **/
-(CGFloat)getLabHeightAttrDic:(NSDictionary *)dict withWidth:(CGFloat)width;

/**
 *json转字典
 **/
-(NSDictionary *)JSONStringToDictionaryWithData;
@end

NS_ASSUME_NONNULL_END
