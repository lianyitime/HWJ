//
//  HWCandidateInfo.h
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWCandidateInfo : NSObject

@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *gender;
@property(nonatomic, strong)NSString *expectMinMoney;
@property(nonatomic, strong)NSString *expectMaxMoney;
@property(nonatomic, strong)NSString *wordYear;
@property(nonatomic, strong)NSString *companyTags;
@property(nonatomic, strong)NSString *skill;
@property(nonatomic, strong)NSString *skillYear;
@property(nonatomic, strong)NSString *appUrl;
@property(nonatomic, strong)NSString *appName;
@property(nonatomic, strong)NSString *appDesc;
@property(nonatomic, strong)NSString *appIconUrl;
@property(nonatomic, strong)NSString *blogType;
@property(nonatomic, strong)NSString *blogUrl;
@property(nonatomic, strong)NSString *collageName;
@property(nonatomic, strong)NSString *subcollageName;
@property(nonatomic, strong)NSString *collageLevel;
@property(nonatomic, strong)NSString *finishyear;

@end
