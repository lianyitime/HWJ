//
//  HWRecommendJobsListController.m
//  HWJ
//
//  Created by zhiyuan on 16/8/3.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWRecommendJobsListController.h"
#import "HWJobBaseInfo.h"
#import "ZYAdTipsView.h"

@interface HWRecommendJobsListController ()

@end

@implementation HWRecommendJobsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAdTip
{
    [ZYAdTipsView showInTable:self.tableView withTitle:@"内部员工推荐，入职BAT不太遥不可及"];
}

- (void)loadData
{
    HWJobBaseInfo *candi = [[HWJobBaseInfo alloc] init];
    candi.title = @"Android工程师";
    candi.expectMaxMoney = @"30K";
    candi.expectMinMoney = @"20K";
    candi.expectYear = @"5年以上";
    candi.location = @"中关村";
    candi.company = @"百度";
    candi.userTitle = @"开发工程师";
    candi.userName = @"张三";
    candi.userImgUrl = @"http://tva4.sinaimg.cn/crop.0.0.180.180.180/62667ea8jw1e8qgp5bmzyj2050050aa8.jpg";
    candi.appName = @"涟漪相册";
    candi.peoples = @"10000人以上";
    candi.jobType = 0;
    
    self.jobs = [[NSMutableArray alloc] initWithObjects:candi, nil];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
