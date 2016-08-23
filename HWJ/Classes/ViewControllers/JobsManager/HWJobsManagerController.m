//
//  HWJobsManagerController.m
//  HWJ
//
//  Created by zhiyuan on 16/8/22.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJobsManagerController.h"
#import "HWJobSettingCell.h"

@interface HWJobsManagerController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UITableView *currentJobsList;

@property (nonatomic, strong)UITableView *historyJobsList;

@property (nonatomic, strong)NSArray *currentJobs;

@property (nonatomic, strong)NSArray *historyJobs;

@end

@implementation HWJobsManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UISegmentedControl *ctrl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"招聘中", @"历史招聘", nil]];
    [ctrl setSelectedSegmentIndex:0];
    [ctrl addTarget:self action:@selector(onSelectedItemChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = ctrl;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - 49 - 64)];
    scroll.pagingEnabled = YES;
    [self.view addSubview:scroll];
    self.scrollView = scroll;
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    UITableView *tempUserList = [[UITableView alloc] initWithFrame:scroll.bounds style:UITableViewStylePlain];
    tempUserList.delegate = self;
    tempUserList.dataSource = self;
    tempUserList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scroll addSubview:tempUserList];
    self.currentJobsList = tempUserList;
    [self.currentJobsList registerClass:[HWJobSettingCell class] forCellReuseIdentifier:@"candiCell"];
    
    CGRect frame = scroll.bounds;
    frame.origin.x += frame.size.width;
    UITableView *processList = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    processList.delegate = self;
    processList.dataSource = self;
    processList.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scroll addSubview:processList];
    self.historyJobsList = processList;
    [self.historyJobsList registerClass:[HWJobSettingCell class] forCellReuseIdentifier:@"candiCell"];
    
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
    
    self.currentJobs = [[NSMutableArray alloc] initWithObjects:candi, nil];
    
    self.historyJobs = [[NSMutableArray alloc] initWithObjects:candi, nil];
    
    [self.currentJobsList reloadData];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.currentJobsList) {
        return 5;//return self.tempUsers.count;
    }
    else {
        return  10;//return self.processUsers.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWJobSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"candiCell"];
    HWJobBaseInfo *candi = [self.currentJobs firstObject];
    [cell loadData:candi];
    //cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

@end
