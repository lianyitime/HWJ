//
//  HWJosbListController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJosbListController.h"
#import "HWJobInfoCell.h"
#import "HWJobBaseInfo.h"

@interface HWJosbListController()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation HWJosbListController

- (instancetype)init
{
    self =[super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[HWJobInfoCell class] forCellReuseIdentifier:@"jobCell"];
    [table setDelegate:self];
    [table setDataSource:self];
    [self.view addSubview:table];
    
    [self loadData];
}

- (void)loadData
{
    HWJobBaseInfo *candi = [[HWJobBaseInfo alloc] init];
    candi.title = @"iOS高级工程师";
    candi.expectMaxMoney = @"15K";
    candi.expectMinMoney = @"12K";
    candi.expectYear = @"3年以上";
    candi.location = @"望京";
    candi.company = @"哈哈科技";
    candi.userTitle = @"CXO";
    candi.userName = @"杨志远";
    candi.userImgUrl = @"http://tva4.sinaimg.cn/crop.0.0.180.180.180/62667ea8jw1e8qgp5bmzyj2050050aa8.jpg";
    candi.appName = @"涟漪相册";
    candi.peoples = @"20-50人";
    
    self.jobs = [[NSMutableArray alloc] initWithObjects:candi, nil];
    [self.tableView reloadData];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.jobs.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//return self.jobs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWJobInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jobCell"];
    [cell loadData:[self.jobs firstObject]];
    return cell;
}

@end
