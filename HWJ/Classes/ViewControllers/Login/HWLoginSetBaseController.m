//
//  HWLoginSetBaseController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWLoginSetBaseController.h"

@implementation HWLoginSetBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    [self loadItems];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(doNext)];
}

@end
