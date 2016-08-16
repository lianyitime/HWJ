//
//  HWCandidateInfoCell.h
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWCandidateInfo.h"

typedef enum {
    HWCandidateEventSendMsg,
    HWCandidateEventClickBlog,
    HWCandidateEventClickProduct
}HWCandidateEvent;

@class HWCandidateInfoCell;

@protocol HWCandidateInfoDelegate <NSObject>

- (void)onClickCell:(HWCandidateInfoCell *)cell event:(HWCandidateEvent)event;

@end

@interface HWCandidateInfoCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)loadData:(HWCandidateInfo *)data;

@property (nonatomic, weak)id<HWCandidateInfoDelegate> delegate;

@end
