//
//  LYLoginedAccount.h
//  Ripple
//
//  Created by zhiyuan on 15/6/4.
//  Copyright (c) 2015年 LianYi. All rights reserved.
//

#import "LYUserInfo.h"

@interface LYLoginedAccount : LYUserInfo

//登录token
@property (nonatomic, strong)NSString *userToken;

- (id)initWithDic:(NSDictionary *)userInfo;

@end
