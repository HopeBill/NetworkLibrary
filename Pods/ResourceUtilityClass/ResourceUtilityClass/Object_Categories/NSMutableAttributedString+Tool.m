//
//  NSMutableAttributedString+Tool.m
//  OneKeyBrother
//
//  Created by Bill on 7/5/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import "NSMutableAttributedString+Tool.h"

@implementation NSMutableAttributedString (Tool)
- (void)TitleFont:(CGFloat)size withColor:(UIColor*)color withRange:(NSRange)range{
    
    [self addAttribute:NSFontAttributeName
     
                 value:[UIFont boldSystemFontOfSize:size]
     
                 range:range];
    
    [self addAttribute:NSForegroundColorAttributeName
     
                 value:color
     
                 range:range];
}
/**
 *给字体添加横线
 **/
-(void)addHorizontallLine:(UIColor*)color{
    [self addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0,self.length)];
    [self addAttribute:NSStrikethroughColorAttributeName value:color range:NSMakeRange(0,self.length)];
}
@end
