//
//  HWJobSettingCell.m
//  HWJ
//
//  Created by zhiyuan on 16/8/23.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJobSettingCell.h"
#import "Masonry.h"
#import "UIButton+EMWebCache.h"

@interface HWJobSettingCell()

@property(nonatomic, strong)UIView *cardBgView;

@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UILabel *expectYear;

@property(nonatomic, strong)UILabel *expectMoney;

@property (nonatomic,strong)UILabel *location;

@property (nonatomic, strong)UILabel *skillsLabel;

@end

@implementation HWJobSettingCell

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
    
    UILabel *location = [[UILabel alloc] init];
    [location setFont:[UIFont systemFontOfSize:12]];
    [location setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:location];
    self.location = location;
    
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(yearImgView.mas_left).offset(-10);
        make.centerY.mas_equalTo(yearImgView.mas_centerY);
    }];
    
    UIImageView *expectImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:expectImgView];
    [expectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(location.mas_centerY);
        make.right.mas_equalTo(location.mas_left).offset(-5);
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
    
    UILabel *skillTip = [[UILabel alloc] init];
    [skillTip setFont:[UIFont systemFontOfSize:12]];
    [skillTip setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:skillTip];
    [skillTip setText:@"技能要求:"];
    
    [skillTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(sepLine1.mas_bottom).offset(15);
    }];
    
    UILabel *skillsLabel = [[UILabel alloc] init];
    [skillsLabel setFont:[UIFont systemFontOfSize:12]];
    [skillsLabel setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    //[skillsLabel setNumberOfLines:0];
    [self.cardBgView addSubview:skillsLabel];
    self.skillsLabel = skillsLabel;
    
    [skillsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(skillTip.mas_right).offset(5);
        //make.top.mas_equalTo(skillTip.mas_top).offset(15);
        make.centerY.mas_equalTo(skillTip.mas_centerY);
        make.right.mas_equalTo(self.cardBgView.mas_right).offset(-5);
       // make.height.lessThanOrEqualTo(self.cardBgView.mas_bottom).offset(-10);
    }];
}

- (void)loadData:(HWJobBaseInfo *)data
{
    [self.nameLabel setText:data.title];
    
    [self.expectMoney setText:[NSString stringWithFormat:@"%@-%@", data.expectMinMoney, data.expectMaxMoney]];
    [self.expectYear setText:data.expectYear];
    [self.location setText:data.location];

    [self.skillsLabel setText:@"XCode, OC, runtime, 多线程,http,动画, MVC"];
}

- (void)sendInviteMsg:(UIButton *)sender
{
//    if ([self.delegate respondsToSelector:@selector(onClickCell:event:)]) {
//        [self.delegate onClickCell:self event:HWJobInfoEventSendMsg];
//    }
}

- (void)onSelectedProduct:(UIButton *)sender
{
    
}

@end
