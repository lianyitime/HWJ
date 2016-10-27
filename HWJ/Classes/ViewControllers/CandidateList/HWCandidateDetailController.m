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
#import "HWSetInterviewQuestionController.h"
#import "MBProgressHUD+MJ.h"
#import "HWJVideoPlayerController.h"
#import "HWPdfReviewCell.h"
#import <WebKit/WebKit.h>

typedef enum {
    HWInterviewStatusStart,
    HWInterviewStatusSend,
    HWInterviewStatusFinished,
}HWInterviewStatus;

@interface HWCandidateDetailController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)HWCandidateInfo *jobInfo;

@property (nonatomic, assign)HWInterviewStatus interviewStatus;

@property (nonatomic, strong)UIButton *sendBt;

@property (nonatomic, assign) BOOL scrollUporDown;

@property (nonatomic, assign) BOOL hidden;

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
    [table registerClass:[HWPdfReviewCell class] forCellReuseIdentifier:@"HWPdfReviewCell"];
    
    [table setDelegate:self];
    [table setDataSource:self];
    [table setContentInset:UIEdgeInsetsMake(0, 0, 49, 0)];
    [self.view addSubview:table];
    self.tableView = table;
    
    [self loadData];
    
    UIButton *sendMsgBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendMsgBt setBackgroundColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [sendMsgBt setTitle:@"邀请视频面试" forState:UIControlStateNormal];
    [sendMsgBt addTarget:self action:@selector(onSendMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMsgBt];
    self.sendBt = sendMsgBt;
    
    [sendMsgBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(49.);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showAdTip];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.hidden) {
        [self scrollToShowToolBar];
        self.hidden = NO;
    }

}

- (void)showAdTip
{
    [ZYAdTipsView showInTable:self.tableView withTitle:@"招聘再也不局限于时间，随时随地进行"];
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

- (void)onSendMsg:(UIButton *)sender
{
    if (self.interviewStatus == HWInterviewStatusStart) {
        HWSetInterviewQuestionController *questionVC = [[HWSetInterviewQuestionController alloc] init];
        questionVC.delegate = self;
        [self.navigationController pushViewController: questionVC animated:YES];
    }
    else if(self.interviewStatus == HWInterviewStatusSend) {
        
    }
    else if(self.interviewStatus == HWInterviewStatusFinished) {
        HWJVideoPlayerController *vc = [[HWJVideoPlayerController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)onSetFinished:(BOOL)success
{
    self.interviewStatus = HWInterviewStatusSend;
    [self.sendBt setTitle:@"已发送面试邀请" forState:UIControlStateNormal];
    
    [self performSelector:@selector(onFinishedInterview) withObject:nil afterDelay:2.];
}

- (void)onFinishedInterview
{
    [MBProgressHUD showTipsMessage:@"候选人已内完成面试" toView:self.view];
    self.interviewStatus = HWInterviewStatusFinished;
    [self.sendBt setTitle:@"查阅面试视频" forState:UIControlStateNormal];
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
            HWCandidateDetailEducation *infoCell = [tableView dequeueReusableCellWithIdentifier:@"HWCandidateDetailEducation"];
            [infoCell loadData:self.jobInfo];
            return infoCell;
        }
            break;
        case 3:
        {
            HWPdfReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HWPdfReviewCell"];

            return cell;
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
        case 3:
            return 200;
        default:
            return 50;
            break;
    }
}

- (void)scrollToShowToolBar
{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.navigationController.navigationBar.frame.size.height);
        CGFloat tabHeight = self.tabBarController.tabBar.frame.size.height;
        self.tabBarController.tabBar.frame = CGRectMake(0 , [UIScreen mainScreen].bounds.size.height - tabHeight , self.view.bounds.size.width, tabHeight);
    }];
}

- (void)scrollToHideToolBar
{
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat navBarHieght = self.navigationController.navigationBar.frame.size.height;
        self.navigationController.navigationBar.frame = CGRectMake(0, -(navBarHieght + 20.0), self.view.bounds.size.width, navBarHieght);
        CGFloat tabHeight = self.tabBarController.tabBar.frame.size.height;
        self.tabBarController.tabBar.frame = CGRectMake(0 , [UIScreen mainScreen].bounds.size.height + tabHeight, self.view.bounds.size.width, tabHeight);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableView] && self.navigationController.topViewController == self) {
        static float newy = 0;
        static float oldy = 0;
        newy = scrollView.contentOffset.y;
        if (newy > 0) {
            if (newy != oldy ) {
                if (newy > oldy) {
                    self.scrollUporDown = YES;
                }else if(newy < oldy){
                    self.scrollUporDown = NO;
                }
                oldy = newy;
            }
            if (_scrollUporDown == YES) {
                self.hidden = YES;
                [self scrollToHideToolBar];
            }
            else if (_scrollUporDown == NO) {
                if (self.hidden == YES) {
                    [self scrollToShowToolBar];
                    self.hidden = NO;
                }
            }
        }
    }
}

@end
