//
//  ZYDoubleBtHeaderView.m
//  HWJ
//
//  Created by zhiyuan on 16/8/18.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "ZYDoubleBtHeaderView.h"
#import "Masonry.h"

@interface ZYDoubleBtHeaderView()

@property (nonatomic, strong)UIButton *leftBt;

@property (nonatomic, strong)UIButton *rightBt;

@end

@implementation ZYDoubleBtHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //[self performSelector:@selector(loadSubviews) withObject:nil afterDelay:0.];
    [self loadSubviews];
    return self;
}

- (void)loadSubviews
{
    UIView *sepLine = [[UIView alloc] init];
    [sepLine setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.mas_height).offset( -4);
        make.width.mas_equalTo(1.0);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).multipliedBy(0.5);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.leftBt = left;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    [right.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).multipliedBy(1.5);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.rightBt = right;
    
}

- (void)setLeftTitle:(NSString *)title
{
    [self.leftBt setTitle:title forState:UIControlStateNormal];
}

- (void)setRightTitle:(NSString *)title
{
    [self.rightBt setTitle:title forState:UIControlStateNormal];
}

@end
