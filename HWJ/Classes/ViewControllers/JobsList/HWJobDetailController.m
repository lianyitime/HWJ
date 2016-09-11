//
//  HWJobDetailController.m
//  HWJ
//
//  Created by zhiyuan on 16/8/24.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJobDetailController.h"
#import "ZYAdTipsView.h"
#import "HWJobBaseInfo.h"
#import "HWJobDetailInfoCell.h"
#import "HWJobBossInfoCell.h"
#import "HWJobDetailRequestCell.h"
#import "HWSayHelloView.h"

@interface HWJobDetailController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)HWJobBaseInfo *jobInfo;

@end

@implementation HWJobDetailController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.title = @"职位详情";
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[HWJobDetailInfoCell class] forCellReuseIdentifier:@"HWJobDetailInfoCell"];
    [table registerClass:[HWJobBossInfoCell class] forCellReuseIdentifier:@"HWJobBossInfoCell"];
    [table registerClass:[HWJobDetailRequestCell class] forCellReuseIdentifier:@"HWJobDetailRequestCell"];
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
    HWJobBaseInfo *candi = [[HWJobBaseInfo alloc] init];
    candi.title = @"iOS高级工程师";
    candi.expectMaxMoney = @"15K";
    candi.expectMinMoney = @"12K";
    candi.expectEdutation = @"本科";
    candi.expectYear = @"3年以上";
    candi.location = @"望京";
    candi.company = @"哈哈科技";
    candi.userTitle = @"CXO";
    candi.userName = @"杨志远";
    candi.userImgUrl = @"http://tva4.sinaimg.cn/crop.0.0.180.180.180/62667ea8jw1e8qgp5bmzyj2050050aa8.jpg";
    candi.appName = @"涟漪相册";
    candi.peoples = @"20-50人";
    candi.jobType = 0;
    
    self.jobInfo = candi;
    [self.tableView reloadData];
}

- (void)onSendMsg:(id)sender
{
    HWSayHelloView *helloView = [[HWSayHelloView alloc] initWithFrame:self.view.bounds];
    [helloView loadData:nil];
    [self.view addSubview:helloView];
}


#pragma mark - table delegate &datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            HWJobDetailInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"HWJobDetailInfoCell"];
            [infoCell loadData:self.jobInfo];
            return infoCell;
        }
            break;
        case 1:
        {
            HWJobBossInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"HWJobBossInfoCell"];
            [infoCell loadData:self.jobInfo];
            return infoCell;
        }
            break;
        case 2:
        {
            HWJobDetailRequestCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"HWJobDetailRequestCell"];
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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

@end
