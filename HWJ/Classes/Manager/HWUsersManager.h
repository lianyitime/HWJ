//
//  HWUsersManager.h
//  HWJ
//
//  Created by zhiyuan on 16/8/29.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWUserProfile.h"

@interface HWUsersManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong)HWUserProfile *currentUser;

@end
