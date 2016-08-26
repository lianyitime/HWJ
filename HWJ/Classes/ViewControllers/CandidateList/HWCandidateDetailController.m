//
//  HWCandidateDetailController.m
//  HWJ
//
//  Created by zhiyuan on 16/8/24.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWCandidateDetailController.h"
#import "HWCandidateDetailInfoCell.h"
#import "HWCandidateDetailWorkCell.h"
#import "HWCandidateBlogCell.h"
#import "HWCandidateDetailEducation.h"
#import "HWCandidateInfo.h"
#import "ZYAdTipsView.h"

@interface HWCandidateDetailController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)HWCandidateInfo *jobInfo;

@end

@implementation HWCandidateDetailController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[HWCandidateDetailInfoCell class] forCellReuseIdentifier:@"HWCandidateDetailInfoCell"];
    [table registerClass:[HWCandidateDetailWorkCell class] forCellReuseIdentifier:@"HWCandidateDetailWorkCell"];
    [table registerClass:[HWCandidateDetailEducation class] forCellReuseIdentifier:@"HWCandidateDetailEducation"];
    [table registerClass:[HWCandidateBlogCell class] forCellReuseIdentifier:@"HWCandidateBlogCell"];
    
    [table setDelegate:self];
    [table setDataSource:self];
    
    [self.view addSubview:table];
    self.tableView = table;
    
    [self loadData];
    
    UIButton *sendMsgBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendMsgBt setBackgroundColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [sendMsgBt setTitle:@"￥搭讪￥" forState:UIControlStateNormal];
    [sendMsgBt addTarget:self action:@selector(onSendMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMsgBt];
    
    [sendMsgBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49.);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showAdTip];
}

- (void)showAdTip
{
    [ZYAdTipsView showInTable:self.tableView withTitle:@"测试广告位"];
}

- (void)loadData
{
    HWCandidateInfo *candi = [[HWCandidateInfo alloc] init];
    candi.name = @"张三";
    candi.gender = @"男";
    candi.expectMaxMoney = @"15K";
    candi.expectMinMoney = @"12K";
    candi.wordYear = @"3年";
    candi.companyTags = @"微博,搜狐";
    candi.skill = @"iOS";
    candi.skillYear = @"5年";
    candi.appUrl = @"https://itunes.apple.com/us/app/lian-yi-xiang-ce/id1040060813?mt=8";
    candi.appName = @"讲个故事给宝听";
    candi.appDesc = @"宝宝想听妈妈讲故事，一遍遍口干舌燥，现在好了，录下来，可以反复放给宝宝听。";
    candi.dutyDesc = @"负责A、B、C等业务模块的开发，负责项目的基础搭建，XX定义实现,主要用到了XX技术和YY框架";
    candi.appIconUrl = @"http://tva4.sinaimg.cn/crop.0.0.180.180.180/62667ea8jw1e8qgp5bmzyj2050050aa8.jpg";
    candi.blogType = @"github";
    candi.blogUrl = @"https://github.com/rs/SDWebImage";
    candi.collageName = @"清华大学";
    candi.subcollageName = @"软件学院";
    candi.collageLevel = @"本科";
    candi.finishyear = @"09届";
    
    self.jobInfo = candi;
    [self.tableView reloadData];
}

- (void)onSendMsg:(id)sender
{
    
}


#pragma mark - table delegate &datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            HWCandidateDetailInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"HWCandidateDetailInfoCell"];
            [infoCell loadData:self.jobInfo];
            return infoCell;
        }
            break;
        case 1:
        {
            HWCandidateDetailWorkCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"HWCandidateDetailWorkCell"];
            [infoCell loadData:self.jobInfo];
            return infoCell;
        }
            break;
        case 2:
        {
            HWCandidateBlogCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"HWCandidateBlogCell"];
            [infoCell loadData:self.jobInfo];
            return infoCell;
        }
            break;
        case 3:
        {
            HWCandidateDetailEducation *infoCell = [tableView dequeueReusableCellWithIdentifier:@"HWCandidateDetailEducation"];
            [infoCell loadData:self.jobInfo];
            return infoCell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 50.;
            break;
        case 1:
            return 50.;
        case 2:
            return 100;
        default:
            return 50;
            break;
    }
}


@end
