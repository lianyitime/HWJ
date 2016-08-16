//
//  HWProcessListController.m
//  HWJ
//
//  Created by zhiyuan on 16/8/15.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWProcessListController.h"

@interface HWProcessListController ()

@end

@implementation HWProcessListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UISegmentedControl *ctrl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"临时队列", @"跟踪队列", nil]];
    [ctrl setSelectedSegmentIndex:0];
    self.navigationItem.titleView = ctrl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
