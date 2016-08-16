//
//  HWLoginSetExpectController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWLoginSetExpectController.h"
#import "HWNotificationDef.h"

@implementation HWLoginSetExpectController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doNext)];
}

- (void)loadItems
{
    UILabel *head =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140)];
    [head setBackgroundColor:[UIColor whiteColor]];
    [head setText:@"你的期望"];
    [head setTextColor:[UIColor darkTextColor]];
    [head setTextAlignment:NSTextAlignmentCenter];
    [head setFont:[UIFont systemFontOfSize:18]];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:head footerView:nil];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"RETableViewItem"] = @"RETableViewItem";
    
    // Add items to this section
    //
    //__typeof (&*self) __weak weakSelf = self;
    
    REPickerItem *moneytem = [REPickerItem itemWithTitle:@"期望月薪" value:@[@"8K", @"10K"] placeholder:nil options:@[@[@"5K", @"6K", @"7K", @"8K", @"9K", @"10K", @"11K", @"12K", @"13K", @"14K", @"15K", @"16K", @"17K", @"18K", @"19K", @"20K", @"21K", @"22K", @"23K", @"24K", @"25K", @"26K", @"27K", @"28K", @"20K", @"35K", @"40K", @"50K", @"60K", @"80K", @"100K"], @[@"5K",@"8K",@"10K",@"12K",@"15K",@"185K",@"20K",@"25K",@"30K",@"35K",@"40K",@"50K",@"80K",@"100+K"]]];
    
    RETextItem *cityItem  = [RETextItem itemWithTitle:@"工作城市" value:@"北京" placeholder:@"北京"];
    RETextItem *placeItem  = [RETextItem itemWithTitle:@"期望工作区域" value:nil placeholder:@"中关村/上地西二旗/望京/国贸CBD"];

    
    [section addItem:moneytem];
    [section addItem:cityItem];
    [section addItem:placeItem];
    
}

- (void)doNext
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HWUSER_LOGIN_FINISHED object:@"user"];
}

@end
