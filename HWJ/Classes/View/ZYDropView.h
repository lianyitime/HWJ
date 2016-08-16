//
//  ZYDropView.h
//  TestDrop
//
//  Created by zhiyuan on 16/8/16.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDropView : UIView

+ (instancetype)loadHeadInTable:(UITableView *)table height:(CGFloat)height img:(UIImage *)image;

- (void)updateFrame;

@end
