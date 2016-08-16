//
//  HWLoginSetReviewController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWLoginSetReviewController.h"
#import "HWLoginSetExpectController.h"

@interface HWLoginSetReviewController()


@end

@implementation HWLoginSetReviewController

- (void)loadItems
{
    UILabel *head =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140)];
    [head setBackgroundColor:[UIColor whiteColor]];
    [head setText:@"个人履历"];
    [head setTextColor:[UIColor darkTextColor]];
    [head setTextAlignment:NSTextAlignmentCenter];
    [head setFont:[UIFont systemFontOfSize:18]];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:head footerView:nil];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"RETableViewItem"] = @"RETableViewItem";
    
    // Add items to this section
    //
    __typeof (&*self) __weak weakSelf = self;

    RETextItem *languageItem  = [RETextItem itemWithTitle:@"语言" value:nil placeholder:@"最熟悉的开发语言或平台"];
    REPickerItem *pickerItem = [REPickerItem itemWithTitle:@"使用时间" value:@[@"1年"] placeholder:nil options:@[@[@"1年", @"2年", @"3年", @"4年", @"5年", @">5年"]]];
    RETextItem *comparyItem  = [RETextItem itemWithTitle:@"工作过的单位" value:nil placeholder:@"工作过最牛的单位（选填）"];
//    REPickerItem *productPickerItem = [REPickerItem itemWithTitle:@"开发的产品类型" value:@[@"无"] placeholder:nil options:@[@[@"iOS App", @"Android App", @"H5 Web", @"服务器后端", @"无"]]];
//    productPickerItem.onChange = ^(REPickerItem *item){
//        NSLog(@"Value: %@", item.value);
//        
//    };
    RETextItem *prodNameItem  = [RETextItem itemWithTitle:@"开发的产品" value:nil placeholder:@"（选填）"];
    RETextItem *prodLinkItem  = [RETextItem itemWithTitle:@"产品地址" value:nil placeholder:@"网站地址或AppStore地址"];
    RETextItem *prodWorkItem  = [RETextItem itemWithTitle:@"负责的模块" value:nil placeholder:@"负责的模块及使用到的技术"];
    
    RETextItem *blogItem  = [RETextItem itemWithTitle:@"我的博客" value:nil placeholder:@"github/stackoverflow（选填）"];
    
    RETextItem *collageNameItem  = [RETextItem itemWithTitle:@"毕业学校" value:nil placeholder:@"学校名称"];
    RETextItem *subCollageNameItem  = [RETextItem itemWithTitle:@"院系专业" value:nil placeholder:@"软件工程/计算机/电子信息"];
    REDateTimeItem *dateTimeItem = [REDateTimeItem itemWithTitle:@"毕业时间" value:[NSDate date] placeholder:nil format:@"MM/yyyy" datePickerMode:UIDatePickerModeDate];
    dateTimeItem.onChange = ^(REDateTimeItem *item){
        NSLog(@"Value: %@", item.value.description);
    };
    
    dateTimeItem.inlineDatePicker = YES;

    // Use inline picker in iOS 7
    //
    //pickerItem.inlinePicker = YES;
    
    [section addItem:languageItem];
    [section addItem:pickerItem];
    [section addItem:comparyItem];
    [section addItem:prodNameItem];
    [section addItem:prodLinkItem];
    [section addItem:prodWorkItem];
    [section addItem:blogItem];
    [section addItem:collageNameItem];
    [section addItem:subCollageNameItem];
    [section addItem:dateTimeItem];

}

- (void)doNext
{
    HWLoginSetExpectController *expectVC = [[HWLoginSetExpectController alloc] init];
    [self.navigationController pushViewController:expectVC animated:YES];
}

@end
