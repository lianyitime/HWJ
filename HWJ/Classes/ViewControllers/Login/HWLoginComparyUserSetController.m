//
//  HWLoginComparyUserSetController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWLoginComparyUserSetController.h"
#import "HWNotificationDef.h"

@implementation HWLoginComparyUserSetController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doNext)];
}

- (void)loadItems
{
    //__typeof (&*self) __weak weakSelf = self;
    
    UILabel *head =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140)];
    [head setBackgroundColor:[UIColor whiteColor]];
    [head setText:@"个人基本信息"];
    [head setTextColor:[UIColor darkTextColor]];
    [head setTextAlignment:NSTextAlignmentCenter];
    [head setFont:[UIFont systemFontOfSize:18]];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:head footerView:nil];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"RETableViewItem"] = @"RETableViewItem";
    
    // Add items to this section
    //
    RETextItem *titleItem  = [RETextItem itemWithTitle:@"职位" value:nil placeholder:@"CTO/总监/项目经理/无线负责人..."];
    RETextItem *userItem  = [RETextItem itemWithTitle:@"姓名" value:nil placeholder:@"真实姓名"];
    RENumberItem *phoneItem = [RENumberItem itemWithTitle:@"手机号" value:@"" placeholder:@"(123) 456-7890" format:@"(XXX) XXX-XXXX"];
    phoneItem.onEndEditing = ^(RETextItem *item){
        NSLog(@"Value: %@", item.value);
    };
    
    RETextItem *emailItem  = [RETextItem itemWithTitle:@"邮箱" value:nil placeholder:@"收取简历用"];
    //emailItem.validators = @[@"presence", @"email"];
    
    REPickerItem *pickerItem = [REPickerItem itemWithTitle:@"性别" value:@[@"男"] placeholder:nil options:@[@[@"男", @"女"]]];
    pickerItem.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    //pickerItem.inlinePicker = YES;

    //RETextItem *skillItem  = [RETextItem itemWithTitle:@"最拿手技术" value:nil placeholder:@"C++/Java/H5..."];
    //RETextItem *introductItem  = [RETextItem itemWithTitle:@"简要介绍" value:nil placeholder:@"说下自己牛的地方，毕竟牛人总是喜欢和牛人一起干活"];
    
    // Use inline picker in iOS 7
    //
    [section addItem:titleItem];
    [section addItem:userItem];
    [section addItem:phoneItem];
    [section addItem:emailItem];
    [section addItem:pickerItem];
    //[section addItem:skillItem];
    //[section addItem:introductItem];
}

- (void)doNext
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HWUSER_LOGIN_FINISHED object:@"company"];
}

@end