//
//  HWCandidateDetailInfoCell.m
//  HWJ
//
//  Created by zhiyuan on 16/8/25.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWCandidateDetailInfoCell.h"
#import "UIButton+WebCache.h"

@interface HWCandidateDetailInfoCell()

@property(nonatomic, strong)UIView *cardBgView;

@property(nonatomic, strong)UILabel *nameLab;

@property(nonatomic, strong)UIImageView *genderView;

@property(nonatomic, strong)UILabel *expectMoney;

@property(nonatomic, strong)UILabel *workYear;

@property(nonatomic, strong)UILabel *skillLabel;

@property(nonatomic, strong)UILabel *skillYear;

@property(nonatomic, strong)UIButton *userBtview;

@end

@implementation HWCandidateDetailInfoCell

- (void)loadSubviews
{
    [super loadSubviews];
    
    UILabel *name = [[UILabel alloc] init];
    [name setFont:[UIFont systemFontOfSize:14]];
    [name setTextColor:[UIColor darkTextColor]];
    [self.cardBgView addSubview:name];
    self.nameLab = name;
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardBgView.mas_left).offset(10);
        make.top.mas_equalTo(self.cardBgView.mas_top).offset(10);
    }];
    
    UIImageView *gender = [[UIImageView alloc] init];
    [self.cardBgView addSubview:gender];
    self.genderView = gender;
    
    [gender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(name.mas_right).offset(5);
        make.centerY.mas_equalTo(name.mas_centerY);
    }];
    
    UILabel *workYear = [[UILabel alloc] init];
    [workYear setFont:[UIFont systemFontOfSize:11]];
    [workYear setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:workYear];
    self.workYear = workYear;
    [workYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(10);
        make.left.mas_equalTo(self.nameLab.mas_left);
    }];
    
    UIImageView *yearImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:yearImgView];
    [yearImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(workYear.mas_centerY);
        make.left.mas_equalTo(workYear.mas_right).offset(5);
    }];
    
    UILabel *expectLab = [[UILabel alloc] init];
    [expectLab setFont:[UIFont systemFontOfSize:11]];
    [expectLab setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:expectLab];
    self.expectMoney = expectLab;
    
    [expectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yearImgView.mas_right).offset(10);
        make.centerY.mas_equalTo(yearImgView.mas_centerY);
    }];
    
    UIImageView *expectImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:expectImgView];
    [expectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(expectLab.mas_centerY);
        make.left.mas_equalTo(expectLab.mas_right).offset(5);
    }];
    
    UILabel *skillYear = [[UILabel alloc] init];
    [skillYear setFont:[UIFont systemFontOfSize:12]];
    [skillYear setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:skillYear];
    self.skillYear = skillYear;
    
    [skillYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(expectImgView.mas_right).offset(10);
        make.centerY.mas_equalTo(expectImgView.mas_centerY);
    }];
    
    UILabel *skillLabel = [[UILabel alloc] init];
    [skillLabel setFont:[UIFont systemFontOfSize:14]];
    [skillLabel setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [self.cardBgView addSubview:skillLabel];
    self.skillLabel = skillLabel;
    
    [skillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.skillYear.mas_right).offset(5);
        make.centerY.mas_equalTo(expectImgView.mas_centerY);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-15);
    }];
    
    UIButton *userBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBt setClipsToBounds:YES];
    [userBt.layer setCornerRadius:40 /2];
    [self.cardBgView addSubview:userBt];
    self.userBtview = userBt;
    
    [userBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cardBgView.mas_right).mas_offset(-15);
        make.top.mas_equalTo(self.cardBgView.mas_top).offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}

- (void)loadData:(HWCandidateInfo *)data
{
    [self.nameLab setText:data.name];
    if([data.gender isEqualToString:@"男"]) {
        [self.genderView setImage:[UIImage imageNamed:@"about"]];
    }
    else {
        [self.genderView setImage:[UIImage imageNamed:@"genderselect"]];
    }
    
    [self.expectMoney setText:[NSString stringWithFormat:@"%@-%@", data.expectMinMoney, data.expectMaxMoney]];
    [self.workYear setText:data.wordYear];
    [self.skillLabel setText:data.skill];
    [self.skillYear setText:data.skillYear];
    
    [self.userBtview sd_setImageWithURL:[NSURL URLWithString:data.appIconUrl] forState:UIControlStateNormal];
}

@end
