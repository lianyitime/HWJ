//
//  HWSayHelloView.m
//  HWJ
//
//  Created by zhiyuan on 16/9/2.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWSayHelloView.h"
#import "Masonry.h"

@interface HWSayHelloView()

@property (nonatomic, strong)UIView *contentView;

@property (nonatomic, strong)UILabel *userLabel;

@property (nonatomic, strong)UILabel *companyLabel;

@property (nonatomic, strong)UIButton *exitBt;

@property (nonatomic, strong)UILabel *jobLabel;

@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, strong)UIButton *sendBt;

@end

@implementation HWSayHelloView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self loadSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onKeyboardShow:(NSNotification *)notification
{
    CGRect keyboardRect = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];

    CGFloat keyboardDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(- (keyboardRect.size.height - 44) / 2);
        
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self layoutIfNeeded];
    }];
    

}

- (void)onKeyboardHide:(NSNotification *)notification
{
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        
    }];
    
    CGFloat keyboardDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:keyboardDuration animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)loadSubviews
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UIButton *content = [UIButton buttonWithType:UIButtonTypeCustom];
    [content addTarget:self action:@selector(onTapBg:) forControlEvents:UIControlEventTouchUpInside];
    [content setClipsToBounds:YES];
    [content.layer setCornerRadius:4.0];
    [content setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50.0);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(210);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.contentView = content;
    
    UILabel *job = [[UILabel alloc] init];
    [job setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [self.contentView addSubview:job];
    [job mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
    }];
    self.jobLabel = job;
    
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.);
        make.top.mas_equalTo(self.jobLabel.mas_bottom).offset(10.0);
    }];
    self.userLabel = label;
    
    UILabel *company = [[UILabel alloc] init];
    [company setFont:[UIFont systemFontOfSize:13]];

//    [company.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [company.layer setBorderWidth:0.5];
//    [company setClipsToBounds:YES];
//    [company.layer setCornerRadius:3.0];
    
    [self.contentView addSubview:company];
    [company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(self.userLabel.mas_centerY);
    }];
    self.companyLabel = company;
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt addTarget:self  action:@selector(doExitView) forControlEvents:UIControlEventTouchUpInside];
    [bt setImage:[UIImage imageNamed:@"close_circle"] forState:UIControlStateNormal];
    [self.contentView addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30.);
        make.height.mas_equalTo(30.);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
    }];
    self.exitBt = bt;
    
    UITextView *textView = [[UITextView alloc] init];
    [textView setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9]];
    [self.contentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userLabel.mas_left);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.companyLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(100.);
    }];
    self.textView = textView;
    
    UIButton *sendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBt setTitle:@"￥搭讪￥" forState:UIControlStateNormal];
    [sendBt addTarget:self action:@selector(sendInviteMsg:) forControlEvents:UIControlEventTouchUpInside];
    [sendBt.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [sendBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBt setClipsToBounds:YES];
    [sendBt.layer setCornerRadius:4.0];
    [sendBt setBackgroundColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    
    [self.contentView addSubview:sendBt];
    
    [sendBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.textView.mas_right);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(7);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(26);
    }];
    
}

- (void)loadData:(id)data
{
    [self.userLabel setText:@"To:马云"];
    [self.companyLabel setText:@"阿里哈哈"];
    [self.jobLabel setText:@"应聘:阿里CTO"];
}

- (void)sendInviteMsg:(id)sender
{
    
}

- (void)doExitView
{
    [self removeFromSuperview];
}

- (void)onTapBg:(UIButton *)send
{
    [self removeFromSuperview];
}


@end
