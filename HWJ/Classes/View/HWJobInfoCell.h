//
//  HWJobInfoCell.h
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
     HWJobInfoEventSendMsg,
     HWJobInfoEventClickBlog,
     HWJobInfoEventClickProduct
} HWJobInfoEvent;

@class HWJobBaseInfo;
@class HWJobInfoCell;

@protocol HWJobInfoDelegate <NSObject>

- (void)onClickCell:(HWJobInfoCell *)cell event:(HWJobInfoEvent)event;

@end

@interface HWJobInfoCell : UITableViewCell

@property (nonatomic, weak)id<HWJobInfoDelegate> delegate;

- (void)loadData:(HWJobBaseInfo *)data;

- (void)updateJobState;

- (HWJobBaseInfo *)getJobData;

- (NSInteger)getJobState;

@end
