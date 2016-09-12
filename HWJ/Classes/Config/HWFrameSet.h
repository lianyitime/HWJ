//
//  HWFrameSet.h
//  HWJ
//
//  Created by zhiyuan on 16/9/10.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#ifndef HWFrameSet_h
#define HWFrameSet_h

//获取屏幕 宽度、高度
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH_HALF ([UIScreen mainScreen].bounds.size.width)/2.0
#define SCREEN_HEIGHT_HALF ([UIScreen mainScreen].bounds.size.height)/2.0
#define SCALE ([UIScreen mainScreen].scale)
//状态栏、导航栏、标签栏高度
#define STATUS_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)
#define NAVIGATIONBAR_HEIGHT (self.navigationController.navigationBar.frame.size.height)
#define TABBAR_HEIGHT (self.tabBarController.tabBar.frame.size.height)

// 判断设备类型
#define SCREEN_HEIGHT_OF_IPHONE5              568
#define SCREEN_HEIGHT_OF_IPHONE6              667
#define SCREEN_HEIGHT_OF_IPHONE6PLUS          736

#define ISIPHONE5              (SCREEN_HEIGHT == SCREEN_HEIGHT_OF_IPHONE5)
#define ISIPHONE6              (SCREEN_HEIGHT == SCREEN_HEIGHT_OF_IPHONE6)
#define ISIPHONE6PLUS          (SCREEN_HEIGHT == SCREEN_HEIGHT_OF_IPHONE6PLUS)

//字体颜色
#define COLOR_FONT_RED   0xD54A45
#define COLOR_FONT_WHITE 0xFFFFFF
#define COLOR_FONT_LIGHTWHITE 0xEEEEEE
#define COLOR_FONT_DARKGRAY  0x555555
#define COLOR_FONT_GRAY  0x777777
#define COLOR_FONT_LIGHTGRAY  0x999999
#define COLOR_FONT_BLACK 0x000000

//背景颜色
#define COLOR_BG_GRAY      0xEDEDED
#define COLOR_BG_ALPHABLACK     0x88000000
#define COLOR_BG_ORANGE 0xf69e21
#define COLOR_BG_ALPHARED  0x88D54A45
#define COLOR_BG_LIGHTGRAY 0xEEEEEE
#define COLOR_BG_ALPHAWHITE 0x55FFFFFF
#define COLOR_BG_WHITE     0xFFFFFF
#define COLOR_BG_DARKGRAY     0xAFAEAE
#define COLOR_BG_RED       0xD54A45
#define COLOR_BG_BLUE      0x4586DA
#define COLOR_BG_CLEAR     0x00000000


#define COLOR_LINE_GRAY 0xBCBCBC


#define SP_NAV_BG_YELLOW_COLOR  RGBAColor(255.0, 226.0, 84.0, 1.0)
#define SP_NAV_BG_WHITE_COLOR  RGBAColor(255.0, 255.0, 255.0, 1.0)

//rbg转UIColor(16进制)
#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA16(rgbaValue) [UIColor colorWithRed:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbaValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbaValue & 0xFF))/255.0 alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0]

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(R, G, B, A) [UIColor colorWithRed:(R)/255.f green:(G)/255.f blue:(B)/255.f alpha:(A)]

#define mainSize    [UIScreen mainScreen].bounds.size


#endif /* HWFrameSet_h */
