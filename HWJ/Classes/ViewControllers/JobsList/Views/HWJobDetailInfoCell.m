//
//  HWJobDetailInfoCell.m
//  HWJ
//
//  Created by zhiyuan on 16/8/24.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJobDetailInfoCell.h"

@interface HWJobDetailInfoCell()

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UILabel *expectMoney;

@property (nonatomic, strong)UILabel *expectYear;

@property (nonatomic, strong)UILabel *educationLabel;

@property (nonatomic, strong)UILabel *cityLabel;

@property (nonatomic, strong)UILabel *areaLabel;

@end

@implementation HWJobDetailInfoCell

- (void)loadSubviews
{
    [super loadSubviews];
    
    UILabel *name = [[UILabel alloc] init];
    [name setFont:[UIFont systemFontOfSize:14]];
    [name setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [self.cardBgView addSubview:name];
    self.titleLabel = name;
    
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
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
    
    UIImageView *yearImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:yearImgView];
    [yearImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(workYear.mas_centerY);
        make.right.mas_equalTo(workYear.mas_left).offset(-5);
    }];
    
    UILabel *educationLabel = [[UILabel alloc] init];
    [educationLabel setFont:[UIFont systemFontOfSize:12]];
    [educationLabel setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:educationLabel];
    self.educationLabel = educationLabel;
    
    [educationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(yearImgView.mas_left).offset(-10);
        make.centerY.mas_equalTo(yearImgView.mas_centerY);
    }];
    
    UIImageView *expectImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
    [self.cardBgView addSubview:expectImgView];
    [expectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(educationLabel.mas_centerY);
        make.right.mas_equalTo(educationLabel.mas_left).offset(-5);
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
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.centerX.mas_equalTo(self.cardBgView.mas_centerX);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(0.5);
    }];

    
    UILabel *cityLabel = [[UILabel alloc] init];
    [cityLabel setFont:[UIFont systemFontOfSize:12]];
    [cityLabel setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:cityLabel];
    self.cityLabel = cityLabel;
    
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(sepLine1.mas_bottom).offset(15);
    }];
    
    UILabel *area = [[UILabel alloc] init];
    [area setFont:[UIFont systemFontOfSize:12]];
    [area setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:area];
    self.areaLabel = area;
    
    [area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cityLabel.mas_right).offset(5);
        make.top.mas_equalTo(cityLabel.mas_top);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-10);
    }];

}

- (void)loadData:(HWJobBaseInfo *)data
{
    [self.titleLabel setText:data.title];
    
    [self.expectMoney setText:[NSString stringWithFormat:@"%@-%@", data.expectMinMoney, data.expectMaxMoney]];
    [self.expectYear setText:data.expectYear];
    [self.educationLabel setText:data.expectEdutation];
    [self.cityLabel setText:@"北京"];
    [self.areaLabel setText:data.location];
    
}

@end
