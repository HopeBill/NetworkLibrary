//
//  NSString+Tool.m
//  OneKeyBrother
//
//  Created by Bill on 28/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)
//json转字典
-(NSDictionary *)JSONStringToDictionaryWithData{
    NSError * error;
    NSData * m_data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:m_data options:NSJSONReadingMutableContainers error:&error];
    return dict;
}

#pragma mark-获取字符串的宽度
-(CGFloat)widthOfStringFont:(UIFont *)font height:(CGFloat)height{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}
/**
 *获取字符串的高度
 **/
-(CGFloat)heightOfStringFont:(UIFont *)font withWidth:(CGFloat)width{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
    
}
-(CGFloat)getLabHeightAttrDic:(NSDictionary *)dict withWidth:(CGFloat)width{
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size.height;
}
@end
