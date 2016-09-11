//
//  HWUsersManager.m
//  HWJ
//
//  Created by zhiyuan on 16/8/29.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWUsersManager.h"

@interface HWUsersManager()

@end

@implementation HWUsersManager

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
