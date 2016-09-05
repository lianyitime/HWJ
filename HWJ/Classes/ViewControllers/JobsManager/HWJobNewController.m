//
//  HWJobNewController.m
//  HWJ
//
//  Created by zhiyuan on 16/9/5.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJobNewController.h"
#import "MBProgressHUD.h"

@implementation HWJobNewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(doSave)];
}

- (void)doSave
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        hud.labelText = @"添加成功";
        hud.mode = MBProgressHUDModeText;
        dispatch_time_t hideTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(hideTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    });
}

- (void)loadItems
{
    //__typeof (&*self) __weak weakSelf = self;
    
    UILabel *head =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140)];
    [head setBackgroundColor:[UIColor whiteColor]];
    [head setText:@"添加招聘岗位"];
    [head setTextColor:[UIColor darkTextColor]];
    [head setTextAlignment:NSTextAlignmentCenter];
    [head setFont:[UIFont systemFontOfSize:18]];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:head footerView:nil];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"RETableViewItem"] = @"RETableViewItem";
    
    // Add items to this section
    //
    RETextItem *titleItem  = [RETextItem itemWithTitle:@"岗位Title" value:nil placeholder:@"如开发工程师、高级开发工程师"];
    RETextItem *skillItem  = [RETextItem itemWithTitle:@"技能或平台" value:nil placeholder:@"如iOS/Android/Java等"];
    REPickerItem *skillTimePickerItem = [REPickerItem itemWithTitle:@"使用时间" value:@[@"1年"] placeholder:nil options:@[@[@"1年", @"2年", @"3年", @"4年", @"5年", @">5年"]]];
    REPickerItem *moneytem = [REPickerItem itemWithTitle:@"期望月薪" value:@[@"8K", @"10K"] placeholder:nil options:@[@[@"5K", @"6K", @"7K", @"8K", @"9K", @"10K", @"11K", @"12K", @"13K", @"14K", @"15K", @"16K", @"17K", @"18K", @"19K", @"20K", @"21K", @"22K", @"23K", @"24K", @"25K", @"26K", @"27K", @"28K", @"20K", @"35K", @"40K", @"50K", @"60K", @"80K", @"100K"], @[@"5K",@"8K",@"10K",@"12K",@"15K",@"185K",@"20K",@"25K",@"30K",@"35K",@"40K",@"50K",@"80K",@"100+K"]]];
    
    REPickerItem *eduItem = [REPickerItem itemWithTitle:@"学历要求" value:@[@"不限"] placeholder:nil options:@[@[@"不限", @"专科", @"本科", @"211/985"]]];
    
    RETextItem *workItem  = [RETextItem itemWithTitle:@"工作标签" value:@"" placeholder:@"如阿里、腾讯、视频方向、大数据等"];
    
    // Use inline picker in iOS 7
    //
    //pickerItem.inlinePicker = YES;
    
    [section addItem:titleItem];
    [section addItem:skillItem];
    [section addItem:skillTimePickerItem];
    [section addItem:moneytem];
    [section addItem:eduItem];
    [section addItem:workItem];
}

@end
