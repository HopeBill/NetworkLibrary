//
//  MacroHeader.h
//  OneKeyBrother
//
//  Created by Bill on 9/4/2019.
//  Copyright © 2019 Bill. All rights reserved.
//

#ifndef MacroHeader_h
#define MacroHeader_h


#define payURLScheme @"zmualipay"
#define wxURLScheme @"wxd930ea5d5a258f4f"
#define qqURLScheme @"tencent1104936705"
#define qqURLAppid @"1104936705"
#define GaoDeKey  @"8cadb6d120f9b555e7dc63157d876c65"


#define Equal(A,B) [A isEqualToString:B]

#pragma mark ======================屏幕类==============
#define  PageSizeParameter  @(10) //页码数
//导航栏的高度
#define navHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)

#define  BottomHeight  49
#define  AutoLayutBottomHeight  (SCREEN_HEIGHT == 812.0 ? 20 : 0)
#define SafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : 0)
#define tarBarHeight (SCREEN_HEIGHT == 812.0 ? 83 :49)
#define StatusBarHeight (SCREEN_HEIGHT == 812.0 ? 44 : 20)

#define sliderHeight 96
#define ViewHeight SCREEN_HEIGHT-sliderHeight-tarBarHeight-navHeight


#define spellListSliderHeight 84
#define spellListViewHeight SCREEN_HEIGHT-SafeAreaBottomHeight-spellListSliderHeight-navHeight

#define exploreShopOnSliderHeight 64
#define exploreShopOnViewHeight SCREEN_HEIGHT-SafeAreaBottomHeight-exploreShopOnSliderHeight-navHeight

#define storesDetailsHeaderHeight 56
#define storesDetailsViewHeight SCREEN_HEIGHT-storesDetailsHeaderHeight-navHeight



#define MessagerHeight  -8888888

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)


#define AppWindow ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define JustEqual5and6Height(_currentHeight) (([UIScreen mainScreen].bounds.size.width == 320)?((_currentHeight)* 375.0/320.0):(([UIScreen mainScreen].bounds.size.width==375)?(_currentHeight):((_currentHeight)*414.0/375.0)))

#define __I6Width(_width) (([UIScreen mainScreen].bounds.size.width == 320)?((_width)* 320.0/375.0):(([UIScreen mainScreen].bounds.size.width==375)?(_width):((_width)*414.0/375.0)))

#define NetWorkingReformer(CALSS,REFORMER){\
if (!REFORMER) {\
REFORMER=[[CALSS alloc] init];\
}\
return REFORMER;\
}


#define WeakSelf(self)    __block __weak typeof(self)weakSelf=self

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif


#pragma mark ====================== 颜色类======================

#define ColorWithRGBA(R,G,B,A) ([UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A])
#define ColorWithRGB(R,G,B) ([UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0])
#define ColorRGBCG(R,G,B) ([UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0].CGColor)

#define ColorRGBCGA(R,G,B,A) ([UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A].CGColor)
#define LKBColor ColorWithRGB(57,189,233)

//格式0xdae8a6
#define JDCOLOR_FROM_RGB_OxFF_ALPHA(rgbValue, al)                        \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
blue:((float)(rgbValue & 0xFF)) / 255.0             \
alpha:al]


#pragma mark ==================字体=====================
#define systemFont(size) ([UIFont systemFontOfSize:size])
#define AdjustFont(size) ([UIFont systemFontOfSize:SCREEN_WIDTH / 375.0 *size])


#pragma mark==================调试打印======================
#ifdef DEBUG
//#define NSLog(...) NSLog(__VA_ARGS__)
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#define debugMethod() NSLog(@"%s", __func__)

#else
#define NSLog(...)
#define debugMethod()
#endif



#endif /* MacroHeader_h */
