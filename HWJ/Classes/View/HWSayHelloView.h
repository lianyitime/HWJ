//
//  HWSayHelloView.h
//  HWJ
//
//  Created by zhiyuan on 16/9/2.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SayHello)(id sender);

@interface HWSayHelloView : UIView

- (void)loadData:(id)data withHandle:(SayHello)handle;

@end
