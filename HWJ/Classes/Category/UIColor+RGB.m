//
//  UIColor+RGB.m
//  ShiPai
//
//  Created by zhiyuan on 16/3/29.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    return [UIColor colorWithRGBHex:hex alpha:1.0];
}

+(UIColor *)colorWithRGBHex:(UInt32)hex alpha:(float)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    if (alpha > 1.0) {
        alpha = 1.0;
    }
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

+(UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}

@end
