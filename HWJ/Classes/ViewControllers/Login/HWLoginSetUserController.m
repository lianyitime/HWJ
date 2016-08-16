//
//  HWLoginSetUserController.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWLoginSetUserController.h"
#import "HWLoginSetReviewController.h"

@interface HWLoginSetUserController()

@end

@implementation HWLoginSetUserController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancel)];

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
    RETextItem *userItem  = [RETextItem itemWithTitle:@"姓名" value:nil placeholder:@"Text"];
    RENumberItem *phoneItem = [RENumberItem itemWithTitle:@"手机号" value:@"" placeholder:@"(123) 456-7890" format:@"(XXX) XXX-XXXX"];
    phoneItem.onEndEditing = ^(RETextItem *item){
        NSLog(@"Value: %@", item.value);
    };
    
    REPickerItem *pickerItem = [REPickerItem itemWithTitle:@"性别" value:@[@"男"] placeholder:nil options:@[@[@"男", @"女"]]];
    pickerItem.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    
    // Use inline picker in iOS 7
    //
    //pickerItem.inlinePicker = YES;
    
    [section addItem:userItem];
    [section addItem:phoneItem];
    [section addItem:pickerItem];
}

- (void)doCancel
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)doNext
{
    HWLoginSetReviewController *review = [[HWLoginSetReviewController alloc] init];
    [self.navigationController pushViewController:review animated:YES];
}

@end
