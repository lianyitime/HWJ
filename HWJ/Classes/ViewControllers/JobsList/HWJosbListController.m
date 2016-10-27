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
#import "ZYAdTipsView.h"
#import "EaseSDKHelper.h"
#import "HWJobDetailController.h"
#import "HWSayHelloView.h"
#import "RKNotificationHub.h"
#import "MBProgressHUD+MJ.h"
#import "SPMiniVideoRecorderController.h"

@interface HWJosbListController()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong)RKNotificationHub *dollarHub;
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
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[HWJobInfoCell class] forCellReuseIdentifier:@"jobCell"];
    [table setDelegate:self];
    [table setDataSource:self];
    [self.view addSubview:table];
    self.tableView = table;
    

//    UIBarButtonItem *speaceRight = [[UIBarButtonItem alloc]
//                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                    target:nil action:nil];
//    
//    UIBarButtonItem *dollarBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dollar"] style:UIBarButtonItemStylePlain target:self action:@selector(onDollarMsg)];
//    self.navigationItem.rightBarButtonItems = @[speaceRight, dollarBar];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSerach)];
    
    //[self performSelector:@selector(showAdTip) withObject:nil afterDelay:0.5];
    [self showAdTip];

//    RKNotificationHub *hub = [[RKNotificationHub alloc] initWithView:self.tabBarItem.
//    self.dollarHub = hub;
//    
//    [self.dollarHub increment];
    
    [self loadData];
}

- (void)showAdTip
{
    [ZYAdTipsView showInTable:self.tableView withTitle:@"面试不用东奔西跑，在家即可随时面试"];
//    [self.dollarHub incrementBy:2];
//    [self.dollarHub pop];
}

- (void)loadData
{
    self.jobs = [[NSMutableArray alloc] initWithCapacity:5];

    for (NSInteger index = 0; index < 5; index++) {
        HWJobBaseInfo *candi = [[HWJobBaseInfo alloc] init];
        candi.title = @"iOS高级工程师";
        candi.expectMaxMoney = @"15K";
        candi.expectMinMoney = @"12K";
        candi.expectYear = @"3年以上";
        candi.expectEdutation = @"本科";
        candi.location = @"望京";
        candi.company = @"哈哈科技";
        candi.userTitle = @"CXO";
        candi.userName = @"杨志远";
        candi.userImgUrl = @"http://tva4.sinaimg.cn/crop.0.0.180.180.180/62667ea8jw1e8qgp5bmzyj2050050aa8.jpg";
        candi.appName = @"涟漪相册";
        candi.peoples = @"20-50人";
        candi.jobType = 0;
        [self.jobs addObject:candi];
        
    }

    [self.tableView reloadData];
}

- (void)onSelectedRMBMsg
{
    
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.jobs.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jobs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 163.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWJobBaseInfo *job = [self.jobs objectAtIndex:indexPath.row];
    HWJobDetailController *detailVC = [[HWJobDetailController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [detailVC loadData:job];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWJobInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jobCell"];
    NSInteger index = [indexPath row];
    [cell loadData:[self.jobs objectAtIndex:index]];
    cell.delegate = self;
    return cell;
}


- (void)onClickCell:(HWJobInfoCell *)cell event:(HWJobInfoEvent)event
{
    switch (event) {
        case HWJobInfoEventSendMsg:
            
        {
            NSInteger jobState = [cell getJobState];
            HWJobBaseInfo *job = [cell getJobData];
            
            switch (jobState) {
                case 0:
                {
                    HWSayHelloView *helloView = [[HWSayHelloView alloc] initWithFrame:self.view.bounds];
                    [helloView loadData:nil withHandle:^(id sender) {
                        [MBProgressHUD showTipsMessage:@"应聘申请已发送" toView:self.view];
                        job.jobState = @"1";
                        [cell updateJobState];
                        
                        [self performSelector:@selector(receiveInterview:) withObject:cell afterDelay:3.];
                    }];
                    [self.view addSubview:helloView];
                }
                    break;
                case 2:
                {
                    [self startVideoInterview:cell];
                }
                    break;
                    
                default:
                    break;
            }
            
//            EMMessage *message = [EaseSDKHelper sendCustomMessageWithTitle:@"测试信息"
//                                                             to:@"8001"
//                                                    messageType:EMChatTypeChat
//                                                        bizType:HWChatBaseMsgTypeReqFindJobByBoss
//                                                     messageExt:nil];
//            //message.ext = @{@"msgBizType":@(HWChatBaseMsgTypeReqFindJobByBoss)}; // 扩展消息部分
//            
//            __weak typeof(self) weakself = self;
//            [[EMClient sharedClient].chatManager asyncSendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
//                if (!aError) {
//                    
//                }
//                else {
//                    
//                }
//            }];
        }
            break;
        case HWJobInfoEventClickBlog:
        {

        }
            break;
        case HWJobInfoEventClickProduct:
        {

        }
            break;
            
        default:
            break;
    }
    
}

- (void)receiveInterview:(HWJobInfoCell *)cell
{
    
    [MBProgressHUD showTipsMessage:@"申请已通过，请24小时内完成面试" toView:self.view];
    HWJobBaseInfo *job = [cell getJobData];

    job.jobState = @"2";
    [cell updateJobState];
}

- (void)startVideoInterview:(HWJobInfoCell *)cell
{
    HWJobBaseInfo *job = [cell getJobData];
    
    SPMiniVideoRecorderController *videoVC = [[SPMiniVideoRecorderController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:videoVC];
    [self presentViewController:navi animated:YES completion:^{
        job.jobState = @"3";
        [cell updateJobState];
    }];
}

- (void)doSerach
{
    
}

- (void)onDollarMsg
{
//    self.dollarHub.count = 0;
//    [self performSelector:@selector(showNewDollarHub) withObject:nil afterDelay:3.0];
}

- (void)showNewDollarHub
{
//    [self.dollarHub incrementBy:arc4random() % 10 + 1];
//    [self.dollarHub pop];
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
