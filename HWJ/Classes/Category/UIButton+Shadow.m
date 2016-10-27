//
//  UIButton+Shadow.m
//  HWJ
//
//  Created by zhiyuan on 16/10/1.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "UIButton+Shadow.h"

@implementation UIButton (Shadow)

- (void)setShadowTitle:(NSString *)title color:(UIColor *)color forState:(UIControlState)state
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 2.0;
    shadow.shadowColor = color;//[UIColor lightGrayColor];
    shadow.shadowOffset = CGSizeMake(2,2);
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:title attributes:[NSDictionary dictionaryWithObjectsAndKeys: shadow, NSShadowAttributeName, @(0), NSVerticalGlyphFormAttributeName, nil]];
    
    [self setAttributedTitle:attStr forState:state];
}

@end
