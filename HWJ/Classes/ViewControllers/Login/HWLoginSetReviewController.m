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

    RETextItem *titleItem  = [RETextItem itemWithTitle:@"专业技能" value:nil placeholder:@"iOS开发/UI设计/运营.."];
    REPickerItem *pickerItem = [REPickerItem itemWithTitle:@"工作经验" value:@[@"1年"] placeholder:nil options:@[@[@"1年", @"2年", @"3年", @"4年", @"5年", @">5年"]]];
    RETextItem *comparyItem  = [RETextItem itemWithTitle:@"曾就职单位" value:nil placeholder:@"工作过最牛的单位（选填）"];
//    REPickerItem *productPickerItem = [REPickerItem itemWithTitle:@"开发的产品类型" value:@[@"无"] placeholder:nil options:@[@[@"iOS App", @"Android App", @"H5 Web", @"服务器后端", @"无"]]];
//    productPickerItem.onChange = ^(REPickerItem *item){
//        NSLog(@"Value: %@", item.value);
//        
//    };
    RETextItem *prodNameItem  = [RETextItem itemWithTitle:@"参与的产品/项目" value:nil placeholder:@"（选填）"];
    RETextItem *prodWorkItem  = [RETextItem itemWithTitle:@"工作职责" value:nil placeholder:@"负责的模块及使用到的技术"];
    
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
    
    [section addItem:titleItem];
    [section addItem:pickerItem];
    [section addItem:comparyItem];
    [section addItem:prodNameItem];
    [section addItem:prodWorkItem];
    
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
