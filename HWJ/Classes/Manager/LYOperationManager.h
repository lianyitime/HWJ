//
//  LYOperationManager.h
//  LianYi
//
//  Created by zhiyuan on 15-1-7.
//  Copyright (c) 2015年 zhiyuan. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface LYOperationManager : AFHTTPRequestOperationManager

+ (instancetype)sharedInstance;

@end
