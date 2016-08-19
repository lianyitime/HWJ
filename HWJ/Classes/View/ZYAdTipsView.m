//
//  ZYAdTipsView.m
//  HWJ
//
//  Created by zhiyuan on 16/8/19.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "ZYAdTipsView.h"

@interface ZYAdTipsView()

@property (nonatomic, weak)UITableView *table;

@end

@implementation ZYAdTipsView

+ (instancetype)showInTable:(UITableView *)table withTitle:(NSString *)title
{
    ZYAdTipsView *view = [[ZYAdTipsView alloc] initWithFrame:CGRectMake(0, -44, table.frame.size.width, 44) title:title];
    [table addSubview:view];
    view.table = table;
    [UIView animateWithDuration:0.5 animations:^{
        UIEdgeInsets inset = table.contentInset;
        inset.top += 44;
        table.contentInset = inset;
    } completion:^(BOOL finished) {
        [view performSelector:@selector(hide) withObject:0 afterDelay:3.0];
    }];
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0.5 alpha:1.]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    [label setText:title];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setTextColor:[UIColor grayColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    
    return self;
}

- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
        UIEdgeInsets inset = self.table.contentInset;
        inset.top -= 44;
        self.table.contentInset = inset;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
