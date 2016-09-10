//
//  LYUserInfo.h
//  LianYi
//
//  Created by zhiyuan on 15-1-10.
//  Copyright (c) 2015年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYUserInfo : NSObject

@property (nonatomic, strong)NSString *account;

@property (nonatomic, strong)NSString *nickName;

@property (nonatomic, strong)NSString *userId;

@property (nonatomic, strong)NSString *headUrl;


- (id)initWithDic:(NSDictionary *)userInfo;

- (NSDictionary *)getInfo;

@end
