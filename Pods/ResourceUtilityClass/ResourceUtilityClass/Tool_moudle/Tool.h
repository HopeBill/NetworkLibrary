//
//  Tool.h
//  zmu
//
//  Created by lee on 2017/8/28.
//  Copyright © 2017年 Libiyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tool : NSObject

/**
 *自定义颜色的图片
 **/
+(UIImage *)imageWithColor:(UIColor *)color;

/**
 *获取当前屏幕显示的viewcontroller
 **/
+(UIViewController*)getCurrentVC;

/**
 *压缩图片
 **/
+(NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

+(NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
