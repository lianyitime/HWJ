//
//  NSString+hmac.h
//  HWJ
//
//  Created by zhiyuan on 16/9/11.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (hmac)

+ (NSString *) hmacSha1:(NSString*)key text:(NSString*)text;

@end
