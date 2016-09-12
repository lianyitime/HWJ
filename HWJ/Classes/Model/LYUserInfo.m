//
//  LYUserInfo.m
//  LianYi
//
//  Created by zhiyuan on 15-1-10.
//  Copyright (c) 2015年 zhiyuan. All rights reserved.
//

#import "LYUserInfo.h"

static NSString *ACCOUNT = @"mobile";
static NSString *NICK_NAME = @"nickName";
static NSString *USER_ID = @"customer_id";
static NSString *USER_HEAD = @"avatar";

@implementation LYUserInfo

- (id)initWithDic:(NSDictionary *)userInfo
{
    self = [super init];
    if (self) {
        self.account = [userInfo objectForKey:ACCOUNT];
        self.nickName = [userInfo objectForKey:NICK_NAME];
        self.userId = [userInfo objectForKey:USER_ID];
        self.headUrl = [userInfo objectForKey:USER_HEAD];
    }
    return self;
}

- (NSDictionary *)getInfo
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    if (self.account) {
        [info setObject:self.account forKey:ACCOUNT];
    }
    if (self.nickName) {
        [info setObject:self.nickName forKey:NICK_NAME];
    }
    if (self.userId) {
        [info setObject:self.userId forKey:USER_ID];
    }
    return info;
}

@end

