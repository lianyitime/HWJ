//
//  HWCandidateDetailWorkCell.m
//  HWJ
//
//  Created by zhiyuan on 16/8/25.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWCandidateDetailWorkCell.h"
#import "UIButton+WebCache.h"

@interface HWCandidateDetailWorkCell()

@property(nonatomic, strong)UILabel *workTipLabel;

@property(nonatomic, strong)UILabel *companyTagLabel;

@property (nonatomic, strong)UILabel *appTipLabel;

@property(nonatomic, strong)UIButton *appNameBt;

@property(nonatomic, strong)UIButton *blogBt;

@end

@implementation HWCandidateDetailWorkCell

- (void)loadSubviews
{
    [super loadSubviews];
    
    UILabel *workTip = [[UILabel alloc] init];
    [workTip setFont:[UIFont systemFontOfSize:12]];
    [workTip setText:@"曾就职于:"];
    [workTip setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:workTip];
    self.workTipLabel = workTip;
    
    [workTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardBgView.mas_left).offset(15);
        make.top.mas_equalTo(self.cardBgView.mas_top).offset(15);
    }];
    
    UILabel *companyLab = [[UILabel alloc] init];
    [companyLab setFont:[UIFont systemFontOfSize:14]];
    [companyLab setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [self.cardBgView addSubview:companyLab];
    self.companyTagLabel = companyLab;
    
    [companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(workTip.mas_centerY);
        make.left.mas_equalTo(workTip.mas_right).offset(5);
    }];
    
    UILabel *productTip = [[UILabel alloc] init];
    [productTip setFont:[UIFont systemFontOfSize:12]];
    [productTip setTextColor:[UIColor grayColor]];
    [productTip setText:@"开发的产品:"];
    [self.cardBgView addSubview:productTip];
    [productTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(workTip.mas_left);
        make.top.mas_equalTo(workTip.mas_bottom).offset(10);
    }];
    
    UIButton *productBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [productBt setTitleColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
    [productBt.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [productBt addTarget:self action:@selector(onSelectedProduct:) forControlEvents:UIControlEventTouchUpInside];
    [self.cardBgView addSubview:productBt];
    self.appNameBt = productBt;
    
    [productBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productTip.mas_right).offset(5);
        make.centerY.mas_equalTo(productTip.mas_centerY);
    }];
    
    UILabel *blogTip = [[UILabel alloc] init];
    [blogTip setFont:[UIFont systemFontOfSize:12]];
    [blogTip setTextColor:[UIColor grayColor]];
    [blogTip setText:@"技术blog:"];
    [self.cardBgView addSubview:blogTip];
    [blogTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productTip.mas_left);
        make.top.mas_equalTo(productTip.mas_bottom).offset(10);
    }];
    
    UIButton *blog = [UIButton buttonWithType:UIButtonTypeCustom];
    [blog setTitleColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
    [blog.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [blog addTarget:self action:@selector(onSelectedBlog:) forControlEvents:UIControlEventTouchUpInside];
    [self.cardBgView addSubview:blog];
    self.blogBt = blog;
    [blog mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(blogTip.mas_right).offset(5);
        make.centerY.mas_equalTo(blogTip.mas_centerY);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-15);

    }];

}

- (void)loadData:(HWCandidateInfo *)data
{
    [self.companyTagLabel setText:data.companyTags];
    [self.appNameBt setTitle:[NSString stringWithFormat:@"%@", data.appName] forState:UIControlStateNormal];
    [self.blogBt setTitle:data.blogType forState:UIControlStateNormal];
}

@end
