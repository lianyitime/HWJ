//
//  LYLoginedAccount.m
//  Ripple
//
//  Created by zhiyuan on 15/6/4.
//  Copyright (c) 2015年 LianYi. All rights reserved.
//

#import "LYLoginedAccount.h"

@implementation LYLoginedAccount

- (id)initWithDic:(NSDictionary *)userInfo
{
    self = [super initWithDic:userInfo];
    self.userToken = [userInfo objectForKey:@"token"];
    return self;
}
@end
