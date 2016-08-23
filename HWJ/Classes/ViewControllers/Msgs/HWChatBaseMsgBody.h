//
//  HWChatBaseMsgBody.h
//  HWJ
//
//  Created by zhiyuan on 16/8/22.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "EMTextMessageBody.h"

typedef enum {
    HWChatBaseMsgTypeReqFindJobByBoss = 100,
    HWChatBaseMsgTypeReqFindJobByRecommend,
    HWChatBaseMsgTypeReqHireByBoss,
    HWChatBaseMsgTypeReqHireByRecommend,
    HWChatBaseMsgTypeRespFindJob,
    HWChatBaseMsgTypeRespHire
} HWChatBaseMsgType;

@interface HWChatBaseMsgBody : EMTextMessageBody

@property (nonatomic, assign)HWChatBaseMsgType msgType;

@end
