//
//  UIColor+RGB.h
//  ShiPai
//
//  Created by zhiyuan on 16/3/29.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGB)

+(UIColor *)colorWithRGBHex:(UInt32)hex;

+(UIColor *)colorWithRGBHex:(UInt32)hex alpha:(float)alpha;

+(UIColor *)colorWithHexString:(NSString *)stringToConvert;  

@end
