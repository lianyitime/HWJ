//
//  SPMiniVideoRecorderController.h
//  ShiPai
//
//  Created by zhiyuan on 16/9/7.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SCRecorder/SCRecorderDelegate.h>

@interface SPMiniVideoRecorderController : UIViewController<SCRecorderDelegate>

@property (nonatomic, strong)UIView *contentView;

@end
