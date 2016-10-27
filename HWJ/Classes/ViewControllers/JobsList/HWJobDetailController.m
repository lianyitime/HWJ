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
#import "MBProgressHUD+MJ.h"

#import "SPMiniVideoRecorderController.h"


@interface HWJobDetailController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIButton *sendMsgBt;

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
    
    UIButton *sendMsgBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendMsgBt setBackgroundColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [sendMsgBt setTitle:@"申请视频面试" forState:UIControlStateNormal];
    [sendMsgBt addTarget:self action:@selector(onSendMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMsgBt];
    self.sendMsgBt = sendMsgBt;
    
    [sendMsgBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49.);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self updateJobState];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showAdTip];
}

- (void)showAdTip
{
    [ZYAdTipsView showInTable:self.tableView withTitle:@"视频面试，再也不用装病请假去面试了"];
}

- (void)loadData:(HWJobBaseInfo *)job
{
    self.jobInfo = job;
    [self.tableView reloadData];
    [self updateJobState];
}

- (void)updateJobState
{
    NSInteger jobState = [self.jobInfo.jobState integerValue];
    switch (jobState) {
        case 0:
            [self.sendMsgBt setTitle:@"申请视频面试" forState:UIControlStateNormal];
            break;
        case 1:
            [self.sendMsgBt setTitle:@"已申请" forState:UIControlStateNormal];
            break;
        case 2:
            [self.sendMsgBt setTitle:@"开始视频面试" forState:UIControlStateNormal];
            break;
        case 3:
            [self.sendMsgBt setTitle:@"已完成面试" forState:UIControlStateNormal];
            break;
            
        default:
            [self.sendMsgBt setTitle:@"申请视频面试" forState:UIControlStateNormal];
            break;
    }
}

- (void)onSendMsg:(id)sender
{
    NSInteger jobState = [self.jobInfo.jobState integerValue];

    switch (jobState) {
        case 0:
        {
            HWSayHelloView *helloView = [[HWSayHelloView alloc] initWithFrame:self.view.bounds];
            [helloView loadData:nil withHandle:^(id sender) {
                [MBProgressHUD showTipsMessage:@"应聘申请已发送" toView:self.view];
                self.jobInfo.jobState = @"1";
                [self updateJobState];
                
                [self performSelector:@selector(receiveInterview) withObject:nil afterDelay:3.];
            }];
            [self.view addSubview:helloView];
        }
            break;
        case 2:
        {
            [self startVideoInterview];
        }
            break;
            
        default:
            break;
    }

}

- (void)receiveInterview
{
    [MBProgressHUD showTipsMessage:@"申请已通过,请24小时内完成面试" toView:self.view];
    self.jobInfo.jobState = @"2";
    [self updateJobState];
}

- (void)startVideoInterview
{
    SPMiniVideoRecorderController *videoVC = [[SPMiniVideoRecorderController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:videoVC];
    [self presentViewController:navi animated:YES completion:^{
        self.jobInfo.jobState = @"3";
        [self updateJobState];
    }];
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

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
@end
