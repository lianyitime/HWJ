//
//  HWJobInfoCell.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJobInfoCell.h"
#import "Masonry.h"
#import "HWJobBaseInfo.h"
#import "UIButton+EMWebCache.h"

@interface HWJobInfoCell()

@property(nonatomic, strong)UIView *cardBgView;

@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UILabel *expectYear;

@property(nonatomic, strong)UILabel *expectMoney;

@property (nonatomic, strong)UILabel *education;

@property (nonatomic,strong)UILabel *location;

@property (nonatomic, strong)UIButton *userBtview;

@property (nonatomic, strong)UILabel *workTipLabel;;

@property (nonatomic, strong)UILabel *userInfoLabel;

@property (nonatomic, strong)UIButton *appNameBt;

@property (nonatomic, strong)UILabel *peoplesLabel;

@property (nonatomic, strong)UIButton *sendMsgBt;

@end

@implementation HWJobInfoCell

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
    [name setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [self.cardBgView addSubview:name];
    self.nameLabel = name;
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardBgView.mas_left).offset(10);
        make.top.mas_equalTo(self.cardBgView.mas_top).offset(10);
    }];
    
    UILabel *workYear = [[UILabel alloc] init];
    [workYear setFont:[UIFont systemFontOfSize:11]];
    [workYear setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:workYear];
    self.expectYear = workYear;
    [workYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cardBgView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
    }];
    
    UIImageView *yearImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:yearImgView];
    [yearImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(workYear.mas_centerY);
        make.right.mas_equalTo(workYear.mas_left).offset(-5);
    }];
    
    UILabel *education = [[UILabel alloc] init];
    [education setFont:[UIFont systemFontOfSize:12]];
    [education setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:education];
    self.education = education;
    
    [education mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(yearImgView.mas_left).offset(-10);
        make.centerY.mas_equalTo(yearImgView.mas_centerY);
    }];
    
    UIImageView *expectImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:expectImgView];
    [expectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(education.mas_centerY);
        make.right.mas_equalTo(education.mas_left).offset(-5);
    }];
    
    UILabel *expectLab = [[UILabel alloc] init];
    [expectLab setFont:[UIFont systemFontOfSize:11]];
    [expectLab setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [self.cardBgView addSubview:expectLab];
    self.expectMoney = expectLab;
    
    [expectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(expectImgView.mas_left).offset(-10);
        make.centerY.mas_equalTo(expectImgView.mas_centerY);
    }];
    
    UIImageView *sepLine1 = [[UIImageView alloc] init];
    [sepLine1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.cardBgView addSubview:sepLine1];
    [sepLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.centerX.mas_equalTo(self.cardBgView.mas_centerX);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
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
    [workTip setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:workTip];
    self.workTipLabel = workTip;
    
    [workTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userBt.mas_right).offset(15);
        make.top.mas_equalTo(userBt.mas_top);
    }];
    
    UILabel *workInfo = [[UILabel alloc] init];
    [workInfo setFont:[UIFont systemFontOfSize:12]];
    [workInfo setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:workInfo];
    self.userInfoLabel = workInfo;
    
    [workInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(workTip.mas_right).offset(5);
        make.top.mas_equalTo(workTip.mas_top);
    }];

    UILabel *productTip = [[UILabel alloc] init];
    [productTip setFont:[UIFont systemFontOfSize:12]];
    [productTip setTextColor:[UIColor grayColor]];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 2.0;
    shadow.shadowColor = [UIColor lightGrayColor];
    shadow.shadowOffset = CGSizeMake(2,2);
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"产品线:" attributes:[NSDictionary dictionaryWithObjectsAndKeys: shadow, NSShadowAttributeName, @(0), NSVerticalGlyphFormAttributeName, nil]];
    //[productTip setText:@"产品线:"];
    [productTip setAttributedText:attStr];
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
    
    UIImageView *sepLine2 = [[UIImageView alloc] init];
    [sepLine2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.cardBgView addSubview:sepLine2];
    [sepLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.centerX.mas_equalTo(self.cardBgView.mas_centerX);
        make.top.mas_equalTo(productTip.mas_bottom).offset(15);
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
        make.top.mas_equalTo(sepLine2.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-5);
        make.width.mas_equalTo(70);
    }];
    
    UILabel *location = [[UILabel alloc] init];
    [location setFont:[UIFont systemFontOfSize:12]];
    [location setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:location];
    self.location = location;
    
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.centerY.mas_equalTo(self.sendMsgBt.mas_centerY);
    }];

    UIImageView *aboutImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:aboutImg];
    [aboutImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(location.mas_centerY);
        make.left.mas_equalTo(location.mas_right).offset(5);
    }];
    
    UILabel *peoplesLabel = [[UILabel alloc] init];
    [peoplesLabel setFont:[UIFont systemFontOfSize:12]];
    [peoplesLabel setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:peoplesLabel];
    [peoplesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(aboutImg.mas_right).offset(5);
        make.centerY.mas_equalTo(self.sendMsgBt.mas_centerY);
    }];
    self.peoplesLabel = peoplesLabel;
}

- (void)loadData:(HWJobBaseInfo *)data
{
    [self.nameLabel setText:data.title];
    
    [self.expectMoney setText:[NSString stringWithFormat:@"%@-%@", data.expectMinMoney, data.expectMaxMoney]];
    [self.expectYear setText:data.expectYear];
    [self.location setText:data.location];
    if (data.jobType == 0) {
        [self.workTipLabel setText:@"面试官:"];
    }
    else {
        [self.workTipLabel setText:@"内推人:"];
    }
    [self.education setText:@"本科"];
    [self.userBtview sd_setImageWithURL:[NSURL URLWithString:data.userImgUrl] forState:UIControlStateNormal];
    [self.userInfoLabel setText:[NSString stringWithFormat:@"%@ | %@ | %@", data.userName, data.userTitle, data.company]];
    [self.appNameBt setTitle:[NSString stringWithFormat:@"%@", data.appName] forState:UIControlStateNormal];
    [self.peoplesLabel setText:[NSString stringWithFormat:@"规模:%@",data.peoples]];
}

- (void)sendInviteMsg:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(onClickCell:event:)]) {
        [self.delegate onClickCell:self event:HWJobInfoEventSendMsg];
    }
}

- (void)onSelectedProduct:(UIButton *)sender
{
    
}
@end
