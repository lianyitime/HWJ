//
//  HWCandidateInfoCell.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWCandidateInfoCell.h"
#import "Masonry.h"
#import "UIButton+WebCache.h"

@interface HWCandidateInfoCell()

@property(nonatomic, strong)UIView *cardBgView;

@property(nonatomic, strong)UILabel *nameLab;

@property(nonatomic, strong)UIImageView *genderView;

@property(nonatomic, strong)UILabel *expectMoney;

@property(nonatomic, strong)UILabel *workYear;

@property(nonatomic, strong)UILabel *skillLabel;

@property(nonatomic, strong)UILabel *skillYear;

@property(nonatomic, strong)UIButton *userBtview;

//Android/iOS/H5/后端
//@property(nonatomic, strong)UIImageView *appPlatformView;

@property(nonatomic, strong)UILabel *workTipLabel;

@property(nonatomic, strong)UILabel *companyTagLabel;

@property (nonatomic, strong)UILabel *appTipLabel;

@property(nonatomic, strong)UIButton *appNameBt;

@property(nonatomic, strong)UIButton *blogBt;

//江西师大|软件工程|本科|09届
@property(nonatomic, strong)UILabel *collage;

@property(nonatomic, strong)UIButton *sendMsgBt;

@end

@implementation HWCandidateInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self loadSubviews];
    return self;
}

- (void)loadSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    
    UIView *cardView = [[UIView alloc] init];
    [cardView setBackgroundColor:[UIColor whiteColor]];
    [cardView setClipsToBounds:YES];
    [cardView.layer setCornerRadius:4.0];
    [cardView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cardView.layer setBorderWidth:0.5];
    [self.contentView addSubview:cardView];
    self.cardBgView = cardView;
    
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(self.contentView.mas_width).offset(-30);
        make.height.mas_equalTo(self.contentView.mas_height).offset(-14);
    }];
    
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
        make.right.mas_equalTo(self.cardBgView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.nameLab.mas_centerY);
    }];
    
    UIImageView *yearImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:yearImgView];
    [yearImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(workYear.mas_centerY);
        make.right.mas_equalTo(workYear.mas_left).offset(-5);
    }];
    
    UILabel *expectLab = [[UILabel alloc] init];
    [expectLab setFont:[UIFont systemFontOfSize:11]];
    [expectLab setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:expectLab];
    self.expectMoney = expectLab;
    
    [expectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(yearImgView.mas_left).offset(-10);
        make.centerY.mas_equalTo(yearImgView.mas_centerY);
    }];
    
    UIImageView *expectImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:expectImgView];
    [expectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(expectLab.mas_centerY);
        make.right.mas_equalTo(expectLab.mas_left).offset(-5);
    }];
    
    UILabel *skillYear = [[UILabel alloc] init];
    [skillYear setFont:[UIFont systemFontOfSize:12]];
    [skillYear setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:skillYear];
    self.skillYear = skillYear;
    
    [skillYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(expectImgView.mas_left).offset(-10);
        make.centerY.mas_equalTo(expectImgView.mas_centerY);
    }];
    
    UILabel *skillLabel = [[UILabel alloc] init];
    [skillLabel setFont:[UIFont systemFontOfSize:14]];
    [skillLabel setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [self.cardBgView addSubview:skillLabel];
    self.skillLabel = skillLabel;
    
    [skillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.skillYear.mas_left).offset(-5);
        make.centerY.mas_equalTo(expectImgView.mas_centerY);
    }];
    
    UIImageView *sepLine1 = [[UIImageView alloc] init];
    [sepLine1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.cardBgView addSubview:sepLine1];
    [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.centerX.mas_equalTo(self.cardBgView.mas_centerX);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(15);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *userBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBt setClipsToBounds:YES];
    [userBt.layer setCornerRadius:40 /2];
    [self.cardBgView addSubview:userBt];
    self.userBtview = userBt;
    
    [userBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(sepLine1).offset(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *workTip = [[UILabel alloc] init];
    [workTip setFont:[UIFont systemFontOfSize:12]];
    [workTip setText:@"曾供职于:"];
    [workTip setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:workTip];
    self.workTipLabel = workTip;
    
    [workTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userBt.mas_right).offset(15);
        make.top.mas_equalTo(userBt.mas_top);
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
    }];
    
    UIImageView *sepLine2 = [[UIImageView alloc] init];
    [sepLine2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.cardBgView addSubview:sepLine2];
    [sepLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userBtview.mas_left);
        make.centerX.mas_equalTo(self.cardBgView.mas_centerX);
        make.top.mas_equalTo(blogTip.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *sendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBt setTitle:@"￥搭讪￥" forState:UIControlStateNormal];
    [sendBt addTarget:self action:@selector(sendInviteMsg:) forControlEvents:UIControlEventTouchUpInside];
    [sendBt.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [sendBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBt setClipsToBounds:YES];
    [sendBt.layer setCornerRadius:4.0];
    [sendBt setBackgroundColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    
    [self.cardBgView addSubview:sendBt];
    self.sendMsgBt = sendBt;
    
    [sendBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cardBgView.mas_right).offset(-15);
        make.top.mas_equalTo(sepLine2.mas_bottom).offset(7);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-7);
        make.width.mas_equalTo(70);
    }];
    
    UILabel *collage = [[UILabel alloc] init];
    [collage setFont:[UIFont systemFontOfSize:12]];
    [collage setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:collage];
    self.collage = collage;
    
    [collage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.centerY.mas_equalTo(sendBt.mas_centerY);
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
    
    [self.companyTagLabel setText:data.companyTags];
    [self.userBtview sd_setImageWithURL:[NSURL URLWithString:data.appIconUrl] forState:UIControlStateNormal];
    [self.appNameBt setTitle:[NSString stringWithFormat:@"<%@>", data.appName] forState:UIControlStateNormal];
    [self.blogBt setTitle:data.blogType forState:UIControlStateNormal];
    
    [self.collage setText:[NSString stringWithFormat:@"%@|%@|%@", data.collageName, data.subcollageName, data.collageLevel]];
    
}

- (void)sendInviteMsg:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(onClickCell:event:)]) {
        [self.delegate onClickCell:self event:HWCandidateEventSendMsg];
    }
}

- (void)onSelectedBlog:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(onClickCell:event:)]) {
        [self.delegate onClickCell:self event:HWCandidateEventClickBlog];
    }
}

- (void)onSelectedProduct:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(onClickCell:event:)]) {
        [self.delegate onClickCell:self event:HWCandidateEventClickProduct];
    }

}

@end
