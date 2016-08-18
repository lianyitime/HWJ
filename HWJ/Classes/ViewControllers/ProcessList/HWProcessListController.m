//
//  HWProcessListController.m
//  HWJ
//
//  Created by zhiyuan on 16/8/15.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWProcessListController.h"
#import "HWCandidateInfo.h"
#import "HWTempUserCell.h"

@interface HWProcessListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UITableView *tempList;

@property (nonatomic, strong)UITableView *processList;

@property (nonatomic, strong)NSArray *tempUsers;

@property (nonatomic, strong)NSArray *processUsers;

@end

@implementation HWProcessListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UISegmentedControl *ctrl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"临时队列", @"跟踪队列", nil]];
    [ctrl setSelectedSegmentIndex:0];
    [ctrl addTarget:self action:@selector(onSelectedItemChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = ctrl;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.frame.size.height - 64 - 49)];
    scroll.pagingEnabled = YES;
    [self.view addSubview:scroll];
    self.scrollView = scroll;
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    UITableView *tempUserList = [[UITableView alloc] initWithFrame:scroll.bounds style:UITableViewStylePlain];
    tempUserList.delegate = self;
    tempUserList.dataSource = self;
    [scroll addSubview:tempUserList];
    self.tempList = tempUserList;
    [self.tempList registerClass:[HWTempUserCell class] forCellReuseIdentifier:@"candiCell"];
    
    CGRect frame = scroll.bounds;
    frame.origin.x += frame.size.width;
    UITableView *processList = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    processList.delegate = self;
    processList.dataSource = self;
    [scroll addSubview:processList];
    self.processList = processList;
    [self.processList registerClass:[HWTempUserCell class] forCellReuseIdentifier:@"candiCell"];
    
    self.scrollView.contentSize = CGSizeMake(frame.size.width * 2, frame.size.height);
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSelectedItemChanged:(UISegmentedControl *)sender
{
    NSInteger index =  sender.selectedSegmentIndex;
    if (index >= 0) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = index * frame.size.width;
        [self.scrollView scrollRectToVisible:frame animated:YES];
    }
}

- (void)loadData
{
    HWCandidateInfo *candi = [[HWCandidateInfo alloc] init];
    candi.name = @"张三";
    candi.gender = @"男";
    candi.expectMaxMoney = @"15K";
    candi.expectMinMoney = @"12K";
    candi.wordYear = @"5年";
    candi.companyTags = @"微博,搜狐";
    candi.skill = @"iOS";
    candi.skillYear = @"3年";
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
    
    self.tempUsers = [[NSMutableArray alloc] initWithObjects:candi, nil];
    
    self.processUsers = [[NSMutableArray alloc] initWithObjects:candi, nil];
    
    [self.tempList reloadData];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tempList) {
        return 5;//return self.tempUsers.count;
    }
    else {
        return  10;//return self.processUsers.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWTempUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"candiCell"];
    HWCandidateInfo *candi = [self.tempUsers firstObject];
    [cell loadData:candi];
    //cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

@end
