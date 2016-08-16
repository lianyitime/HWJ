//
//  HWLoginSetBaseController.h
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RETableViewManager/RETableViewManager.h>

@interface HWLoginSetBaseController :  UITableViewController<RETableViewManagerDelegate>

@property (strong, readwrite, nonatomic) RETableViewManager *manager;

- (void)loadItems;

- (void)doNext;

@end
