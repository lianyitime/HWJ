//
//  HWJobBaseInfo.h
//  HWJ
//
//  Created by zhiyuan on 16/8/2.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWJobBaseInfo : NSObject

@property (nonatomic, strong)NSString *title;

@property (nonatomic, strong)NSString *expectYear;

@property (nonatomic, strong)NSString *expectMinMoney;

@property (nonatomic, strong)NSString *expectMaxMoney;

@property (nonatomic, strong)NSString *expectEdutation;

@property (nonatomic, strong)NSString *location;

@property (nonatomic, strong)NSString *userImgUrl;

@property (nonatomic, strong)NSString *userName;

@property (nonatomic, strong)NSString *userTitle;

@property (nonatomic, strong)NSString *company;

@property (nonatomic, strong)NSString *appName;

@property (nonatomic, strong)NSString *peoples;

//0 直聘，1 内推
@property (nonatomic, assign)NSInteger jobType;

@end
