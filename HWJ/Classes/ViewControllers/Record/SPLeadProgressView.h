//
//  SPLeadProgressView.h
//  ShiPai
//
//  Created by zhiyuan on 16/9/9.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLeadProgressView : UIView

- (instancetype)initWithMinTime:(CGFloat)min Max:(CGFloat)max;

- (void)updateProgress:(CGFloat)progessTime;

- (void)pauseAtProgress:(CGFloat)progessTime;

- (void)resumeProgress;

- (void)selectLastPart;

- (BOOL)isSelected;

- (void)removeLastPart;

@end
