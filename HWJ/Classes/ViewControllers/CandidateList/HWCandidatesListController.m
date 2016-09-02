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
#import "HWCandidateDetailController.h"

#import "EaseEmoji.h"
#import "EaseEmotionManager.h"

#import "ZYAdTipsView.h"

#import "MKDropdownMenu.h"
#import "UIColor+RGB.h"

static inline void delay(NSTimeInterval delay, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

@interface HWCandidatesListController()<UITableViewDelegate, UITableViewDataSource, HWCandidateInfoDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *jobs;

@property (nonatomic, strong)NSMutableDictionary *emotionDic;

@property (strong, nonatomic) MKDropdownMenu *navBarMenu;

@property (nonatomic, strong)NSString *titleStr;

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
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[HWCandidateInfoCell class] forCellReuseIdentifier:@"candiCell"];
    [table setDelegate:self];
    [table setDataSource:self];
    [self.view addSubview:table];
    self.tableView = table;
    
    self.titleStr = @"候选人";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSerach)];
    
    //[self performSelector:@selector(showAdTip) withObject:nil afterDelay:0.5];
    [self showAdTip];
    
    [self configTitleMenu];
    
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navBarMenu closeAllComponentsAnimated:NO];
}

- (void)configTitleMenu
{
    // Create dropdown menu in code
    
    self.navBarMenu = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.navBarMenu.dataSource = self;
    self.navBarMenu.delegate = self;
    
    // Make background light instead of dark when presenting the dropdown
    self.navBarMenu.backgroundDimmingOpacity = -0.67;
    
    // Set custom disclosure indicator image
    UIImage *indicator = [UIImage imageNamed:@"indicator"];
    self.navBarMenu.disclosureIndicatorImage = indicator;
    
    // Add an arrow between the menu header and the dropdown
    UIImageView *spacer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangle"]];
    
    // Prevent the arrow image from stretching
    spacer.contentMode = UIViewContentModeCenter;
    
    self.navBarMenu.spacerView = spacer;
    
    // Offset the arrow to align with the disclosure indicator
    self.navBarMenu.spacerViewOffset = UIOffsetMake(self.navBarMenu.bounds.size.width/2 - indicator.size.width/2 - 8, 1);
    
    // Hide top row separator to blend with the arrow
    self.navBarMenu.showsTopRowSeparator = NO;
    
    self.navBarMenu.dropdownBouncesScroll = NO;
    
    self.navBarMenu.rowSeparatorColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.navBarMenu.rowTextAlignment = NSTextAlignmentCenter;
    
    // Round all corners (by default only bottom corners are rounded)
    self.navBarMenu.dropdownRoundedCorners = UIRectCornerAllCorners;
    
    // Let the dropdown take the whole width of the screen with 10pt insets
    self.navBarMenu.useFullScreenWidth = YES;
    self.navBarMenu.fullScreenInsetLeft = 10;
    self.navBarMenu.fullScreenInsetRight = 10;
    
    // Add the dropdown menu to navigation bar
    self.navigationItem.titleView = self.navBarMenu;
}

- (void)showAdTip
{
    [ZYAdTipsView showInTable:self.tableView withTitle:@"内推:成功推荐一人可获得奖励1千"];
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
    HWCandidateDetailController *detail = [[HWCandidateDetailController alloc] initWithNibName:nil bundle:nil];
    HWCandidateInfo *candi  = [self.jobs firstObject];
    detail.title = candi.name;
    [self.navigationController pushViewController:detail animated:YES];
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

#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

#pragma mark - MKDropdownMenuDelegate

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
    return 50;
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForComponent:(NSInteger)component {
    return [[NSAttributedString alloc] initWithString:self.titleStr
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightLight],
                                                        NSForegroundColorAttributeName: [UIColor grayColor]}];
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSMutableAttributedString *string =
    [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"岗位%ld", row + 1]
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightLight],
                                                        NSForegroundColorAttributeName: [UIColor grayColor]}];
    return string;
}

- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [UIColor colorWithHexString:@"#1B86E3"];
}

- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForHighlightedRowsInComponent:(NSInteger)component {
    return [UIColor lightGrayColor];
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.titleStr = [NSString stringWithFormat:@"岗位%ld", row + 1];
    [dropdownMenu reloadComponent:component];
    
    delay(0.15, ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
    });
}


@end
