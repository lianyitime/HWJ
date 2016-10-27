//
//  HWSetInterviewQuestionController.h
//  HWJ
//
//  Created by zhiyuan on 16/10/25.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWLoginSetBaseController.h"

@protocol HWWetInterviewDelegate <NSObject>

- (void)onSetFinished:(BOOL)success;

@end

@interface HWSetInterviewQuestionController : HWLoginSetBaseController

@property (nonatomic, weak)id<HWWetInterviewDelegate> delegate;

@end
