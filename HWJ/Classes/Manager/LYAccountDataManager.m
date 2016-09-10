//
//  LYAccountDataManager.m
//  LianYi
//
//  Created by zhiyuan on 15-1-10.
//  Copyright (c) 2015年 zhiyuan. All rights reserved.
//

#import "LYAccountDataManager.h"
//#import "RTAlbumsManager.h"
#import "LYUserInfo.h"

@interface LYAccountDataManager()

@property (nonatomic, assign)BOOL isLoadFriends;

@end

@implementation LYAccountDataManager

+ (id)sharedLYAccountDataManager
{
    static dispatch_once_t pred;
    static LYAccountDataManager *lYAccountDataManager = nil;
    
    dispatch_once(&pred, ^{ lYAccountDataManager = [[self alloc] init]; });
    return lYAccountDataManager;
}

- (void)cleanAllInfo
{
    self.currentUser = nil;
    self.friendsInfo = nil;
    self.isLoadFriends = NO;
}


@end


