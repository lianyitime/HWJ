//
//  HWJobDetailInfoCell.h
//  HWJ
//
//  Created by zhiyuan on 16/8/24.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWRoundBaseCell.h"
#import "HWJobBaseInfo.h"

@interface HWJobDetailInfoCell : HWRoundBaseCell

- (void)loadData:(HWJobBaseInfo *)data;

@end
