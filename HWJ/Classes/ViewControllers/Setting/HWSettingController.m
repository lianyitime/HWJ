//
//  HWSettingController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWSettingController.h"
#import "ZYDropView.h"
#import <RETableViewManager/RETableViewManager.h>
#import "Masonry.h"
#import <UIImageView+WebCache.h>
#import "ZYDoubleBtHeaderView.h"

@interface HWSettingController()<UITableViewDelegate, UITableViewDataSource, RETableViewManagerDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)ZYDropView *dropView;

@property (strong, readwrite, nonatomic) RETableViewManager *manager;

@end

@implementation HWSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //[table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    table.delegate = self;
//    table.dataSource = self;
    [self.view addSubview:table];
    [table setBackgroundColor:[UIColor lightGrayColor]];
    table.tableFooterView = [[UIView alloc] init];
    self.tableView = table;
    
    self.dropView = [ZYDropView loadHeadInTable:self.tableView height:200 img:[UIImage imageNamed:@"toutu"]];
    
    UIImageView *userView = [[UIImageView alloc] init];
    [self.dropView addSubview:userView];
    [userView sd_setImageWithURL:[NSURL URLWithString:@"http://tva4.sinaimg.cn/crop.0.0.180.180.180/62667ea8jw1e8qgp5bmzyj2050050aa8.jpg"]];
    [userView setClipsToBounds:YES];
    [userView.layer setCornerRadius:60./ 2];
    [userView.layer setBorderColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0].CGColor];
    [userView.layer setBorderWidth:2.0];
    
    UILabel *userLabel = [[UILabel alloc] init];
    [userLabel setText:@"杨志远"];
    [userLabel setFont:[UIFont systemFontOfSize:16]];
    [userLabel setTextColor:[UIColor lightTextColor]];
    [self.dropView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(userView.mas_centerX);
    }];
    
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.dropView.mas_centerX);
        make.centerY.mas_equalTo(self.dropView.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    self.manager.delegate = self;
    [self loadItems];

}

- (void)loadItems
{
    //__typeof (&*self) __weak weakSelf = self;
    
//    UILabel *head =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
//    [head setBackgroundColor:[UIColor clearColor]];
//    [head setText:@""];
//    [head setTextColor:[UIColor darkTextColor]];
//    [head setTextAlignment:NSTextAlignmentCenter];
//    [head setFont:[UIFont systemFontOfSize:18]];
    
    ZYDoubleBtHeaderView *head = [[ZYDoubleBtHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [head setLeftTitle:@"梦想基金：100.00"];
    [head setRightTitle:@"今日收益：20.00"];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:head footerView:nil];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"RETableViewItem"] = @"RETableViewCell";
    
    // Add items to this section
    //
    RETableViewItem *review  = [RETableViewItem itemWithTitle:@"简历管理" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    
    RETableViewItem *bill  = [RETableViewItem itemWithTitle:@"基金管理" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    
    RETableViewItem *setting  = [RETableViewItem itemWithTitle:@"设置" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    
    [section addItem:review];
    [section addItem:bill];
    [section addItem:setting];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.dropView updateFrame];
}

@end
