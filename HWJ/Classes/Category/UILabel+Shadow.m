//
//  UILabel+Shadow.m
//  HWJ
//
//  Created by zhiyuan on 16/10/1.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "UILabel+Shadow.h"

@implementation UILabel (Shadow)

- (void)setShadowTitle:(NSString *)title color:(UIColor *)color
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 2.0;
    shadow.shadowColor = color;//[UIColor lightGrayColor];
    shadow.shadowOffset = CGSizeMake(2,2);
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:title attributes:[NSDictionary dictionaryWithObjectsAndKeys: shadow, NSShadowAttributeName, @(0), NSVerticalGlyphFormAttributeName, nil]];
    
    [self setAttributedText:attStr];
}

@end
