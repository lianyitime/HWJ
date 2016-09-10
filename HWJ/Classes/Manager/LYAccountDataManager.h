//
//  LYAccountDataManager.h
//  LianYi
//
//  Created by zhiyuan on 15-1-10.
//  Copyright (c) 2015年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYLoginedAccount.h"
//#import "LYConstDef.h"

@interface LYAccountDataManager : NSObject

+ (instancetype)sharedLYAccountDataManager;

@property (nonatomic, strong)LYLoginedAccount *currentUser;

@property (nonatomic, strong)NSDictionary *friendsInfo;

- (void)cleanAllInfo;

@end
