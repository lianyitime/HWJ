//
//  HWReqJobChatCell.h
//  HWJ
//
//  Created by zhiyuan on 16/8/22.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWCandidateInfo.h"
#import "HWJobBaseInfo.h"

@interface HWReqJobChatCell : UITableViewCell

- (void)loadUserData:(HWCandidateInfo *)data;

- (void)loadJobData:(HWJobBaseInfo *)data;

@end
