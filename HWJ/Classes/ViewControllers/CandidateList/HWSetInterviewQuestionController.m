//
//  HWSetInterviewQuestionController.m
//  HWJ
//
//  Created by zhiyuan on 16/10/25.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWSetInterviewQuestionController.h"
#import "MBProgressHUD+MJ.h"

@implementation HWSetInterviewQuestionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doCancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交试题" style:UIBarButtonItemStyleDone target:self action:@selector(doFinished)];
    
}

- (void)loadItems
{
    //__typeof (&*self) __weak weakSelf = self;
    
    UILabel *head =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140)];
    [head setBackgroundColor:[UIColor whiteColor]];
    [head setText:@"设置试题"];
    [head setTextColor:[UIColor darkTextColor]];
    [head setTextAlignment:NSTextAlignmentCenter];
    [head setFont:[UIFont systemFontOfSize:18]];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderView:head footerView:nil];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"RETableViewItem"] = @"RETableViewItem";
    
    // Add items to this section
    //
    for (NSInteger index = 0; index < 5; index ++) {
        RETextItem * item = [RETextItem itemWithTitle:[NSString stringWithFormat:@"试题%ld", index + 1] value:nil placeholder:@"试题内容"];
        [section addItem:item];
    }
}

- (void)doCancel
{
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)doNext
{
    //HWLoginSetReviewController *review = [[HWLoginSetReviewController alloc] init];
    //[self.navigationController pushViewController:review animated:YES];
}

- (void)doFinished
{
    [MBProgressHUD showTipsMessage:@"已提交试题并发送面试邀请" toView:self.view];
    [self performSelector:@selector(doFinishedSendInterview) withObject:nil afterDelay:2.];
}

- (void)doFinishedSendInterview
{
    if ([self.delegate respondsToSelector:@selector(onSetFinished:)]) {
        [self.delegate onSetFinished:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
