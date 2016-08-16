//
//  HWLoginComparySetController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWLoginComparySetController.h"
#import "HWLoginComparyUserSetController.h"

@implementation HWLoginComparySetController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancel)];
    
}

- (void)loadItems
{
    UILabel *head =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140)];
    [head setBackgroundColor:[UIColor whiteColor]];
    [head setText:@"企业基本信息"];
    [head setTextColor:[UIColor darkTextColor]];
    [head setTextAlignment:NSTextAlignmentCenter];
    [head setFont:[UIFont systemFontOfSize:18]];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:head footerView:nil];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"RETableViewItem"] = @"RETableViewItem";
    
    // Add items to this section
    //
    RETextItem *userItem  = [RETextItem itemWithTitle:@"公司名称" value:nil placeholder:@"Text"];
    RETextItem *prodNameItem  = [RETextItem itemWithTitle:@"主打产品" value:nil placeholder:@"（选填）"];
    RETextItem *prodTypeItem  = [RETextItem itemWithTitle:@"产品领域" value:nil placeholder:@"电商/社交/视频/...（选填）"];
    RETextItem *prodLinkItem  = [RETextItem itemWithTitle:@"产品地址" value:nil placeholder:@"网站地址或AppStore地址"];
    RETextItem *cityItem  = [RETextItem itemWithTitle:@"所在城市" value:@"北京" placeholder:@"北京"];
    RETextItem *locationItem  = [RETextItem itemWithTitle:@"办公地点" value:nil placeholder:@"望京/中关村/CBD"];
    
    REPickerItem *pickerItem = [REPickerItem itemWithTitle:@"公司规模" value:@[@"20-50人"] placeholder:nil options:@[@[@"20人以内", @"20-50人", @"50-100人", @"100-200人", @"200-500人", @"500-1000人", @"1000人以上"]]];
    
//    REPickerItem *basePickerItem = [REPickerItem itemWithTitle:@"融资情况" value:@[@"无需融资"] placeholder:nil options:@[@[@"无需融资", @"天使轮", @"A轮", @"B轮", @"C轮", @"D轮以后", @"上市公司"]]];
//    pickerItem.onChange = ^(REPickerItem *item){
//        NSLog(@"Value: %@", item.value);
//    };
//    
//    RETextItem *baseMoneyItem  = [RETextItem itemWithTitle:@"融资金额" value:nil placeholder:@"（可选）"];
//    RETextItem *baseVCItem  = [RETextItem itemWithTitle:@"投资机构" value:nil placeholder:@"（可选）"];

    // Use inline picker in iOS 7
    //
    //pickerItem.inlinePicker = YES;
    
    [section addItem:userItem];
    [section addItem:prodNameItem];
    [section addItem:prodTypeItem];
    [section addItem:prodLinkItem];
    [section addItem:cityItem];
    [section addItem:locationItem];
    [section addItem:pickerItem];
//    [section addItem:basePickerItem];
//    [section addItem:baseMoneyItem];
//    [section addItem:baseVCItem];

}

- (void)doNext
{
    HWLoginComparyUserSetController *vc = [[HWLoginComparyUserSetController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)doCancel
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
