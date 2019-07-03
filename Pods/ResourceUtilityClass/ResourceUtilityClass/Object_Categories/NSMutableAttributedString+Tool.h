//
//  NSMutableAttributedString+Tool.h
//  OneKeyBrother
//
//  Created by Bill on 7/5/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (Tool)
/**
 *调整字体颜色大小
 **/
- (void)TitleFont:(CGFloat)size withColor:(UIColor*)color withRange:(NSRange)range;
/**
 *给字体添加横线
 **/
-(void)addHorizontallLine:(UIColor*)color;
@end

NS_ASSUME_NONNULL_END
