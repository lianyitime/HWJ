//
//  HWJobBossInfoCell.m
//  HWJ
//
//  Created by zhiyuan on 16/8/24.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJobBossInfoCell.h"
#import "UIButton+EMWebCache.h"

@interface HWJobBossInfoCell()

@property (nonatomic, strong)UIButton *userBtview;

@property (nonatomic, strong)UILabel *workTipLabel;;

@property (nonatomic, strong)UILabel *userInfoLabel;

@property (nonatomic, strong)UIButton *appNameBt;

@end

@implementation HWJobBossInfoCell

- (void)loadSubviews
{
    [super loadSubviews];
    
    UIButton *userBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBt setClipsToBounds:YES];
    [userBt.layer setCornerRadius:40 /2];
    [self.cardBgView addSubview:userBt];
    self.userBtview = userBt;
    
    [userBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.cardBgView.mas_top).offset(10);
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
    [workInfo setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
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
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-10);
    }];
}

- (void)loadData:(HWJobBaseInfo *)data
{
    if (data.jobType == 0) {
        [self.workTipLabel setText:@"面试官:"];
    }
    else {
        [self.workTipLabel setText:@"内推人:"];
    }
    [self.userBtview sd_setImageWithURL:[NSURL URLWithString:data.userImgUrl] forState:UIControlStateNormal];
    [self.userInfoLabel setText:[NSString stringWithFormat:@"%@ | %@ | %@", data.userName, data.userTitle, data.company]];
    [self.appNameBt setTitle:[NSString stringWithFormat:@"%@", data.appName] forState:UIControlStateNormal];
}

@end
