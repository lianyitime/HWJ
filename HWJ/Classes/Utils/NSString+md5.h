//
//  NSString+md5.h
//  Ripple
//
//  Created by zhiyuan on 15/6/4.
//  Copyright (c) 2015年 LianYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)

-(NSString *) md5HexDigest;

@end
