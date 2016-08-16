//
//  HWJobInfoCell.h
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWJobBaseInfo;

@interface HWJobInfoCell : UITableViewCell

- (void)loadData:(HWJobBaseInfo *)data;

@end
