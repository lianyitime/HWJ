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
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[HWJobInfoCell class] forCellReuseIdentifier:@"jobCell"];
    [table setDelegate:self];
    [table setDataSource:self];
    [self.view addSubview:table];
    self.tableView = table;
    
    //[self performSelector:@selector(showAdTip) withObject:nil afterDelay:0.5];
    [self showAdTip];

    [self loadData];
}

- (void)showAdTip
{
    [ZYAdTipsView showInTable:self.tableView withTitle:@"今天投入多几百，明年年薪多几万"];
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
    candi.jobType = 0;
    
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
    HWJobDetailController *detailVC = [[HWJobDetailController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWJobInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jobCell"];
    [cell loadData:[self.jobs firstObject]];
    cell.delegate = self;
    return cell;
}


- (void)onClickCell:(HWJobInfoCell *)cell event:(HWJobInfoEvent)event
{
    switch (event) {
        case HWJobInfoEventSendMsg:
        {
            HWSayHelloView *helloView = [[HWSayHelloView alloc] initWithFrame:self.view.bounds];
            [helloView loadData:nil];
            [self.view addSubview:helloView];
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

@end
