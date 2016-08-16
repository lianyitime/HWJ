//
//  HWCandidatesListController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWCandidatesListController.h"
#import "HWCandidateInfoCell.h"
#import "HWCandidateInfo.h"
#import "EaseMessageViewController.h"
#import "HWNavigationViewController.h"
#import "RxWebViewController.h"

#import "EaseEmoji.h"
#import "EaseEmotionManager.h"

@interface HWCandidatesListController()<UITableViewDelegate, UITableViewDataSource, HWCandidateInfoDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *jobs;

@property (nonatomic, strong)NSMutableDictionary *emotionDic;

@end

@implementation HWCandidatesListController

- (instancetype)init
{
    self =[super init];
    self.title = @"人才";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"人才" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[HWCandidateInfoCell class] forCellReuseIdentifier:@"candiCell"];
    [table setDelegate:self];
    [table setDataSource:self];
    [self.view addSubview:table];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSerach)];
    
    [self loadData];
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
    candi.appIconUrl = @"http://tva4.sinaimg.cn/crop.0.0.180.180.180/62667ea8jw1e8qgp5bmzyj2050050aa8.jpg";
    candi.blogType = @"github";
    candi.blogUrl = @"https://github.com/rs/SDWebImage";
    candi.collageName = @"清华大学";
    candi.subcollageName = @"软件学院";
    candi.collageLevel = @"本科";
    candi.finishyear = @"09届";
    
    self.jobs = [[NSMutableArray alloc] initWithObjects:candi, nil];
    
    [self.tableView reloadData];
}

- (void)doSerach
{
    
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.jobs.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.jobs.count;
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWCandidateInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"candiCell"];
    HWCandidateInfo *candi = [self.jobs firstObject];
    [cell loadData:candi];
    cell.delegate = self;
    return cell;
}

- (void)onClickCell:(HWCandidateInfoCell *)cell event:(HWCandidateEvent)event
{
    switch (event) {
        case HWCandidateEventSendMsg:
        {
            EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"8001" conversationType:EMConversationTypeChat];
            chatController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatController animated:YES];
            chatController.delegate = self;
            chatController.dataSource = self;
        }
            break;
        case HWCandidateEventClickProduct:
        {
            RxWebViewController *webVC = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://itunes.apple.com/us/app/lian-yi-xiang-ce/id1040060813?l=zh&ls=1&mt=8"]];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case HWCandidateEventClickBlog:
        {
            RxWebViewController *webVC = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:@"https://github.com/Roxasora/RxWebViewController"]];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
            
        default:
            break;
    }

}

#pragma mark -msg darasource
- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    _emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"[示例%d]",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
        [emotionGifs addObject:emotion];
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
    }
    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
    
    return @[managerDefault,managerGif];
}

@end
