//
//  HWJobDetailRequestCell.m
//  HWJ
//
//  Created by zhiyuan on 16/8/24.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJobDetailRequestCell.h"

@interface HWJobDetailRequestCell()

@property (nonatomic, strong)UILabel *contentDescLabel;

@end

@implementation HWJobDetailRequestCell

- (void)loadSubviews
{
    [super loadSubviews];
    
    UILabel *skillTip = [[UILabel alloc] init];
    [skillTip setFont:[UIFont systemFontOfSize:12]];
    [skillTip setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:skillTip];
    [skillTip setText:@"职能与要求:"];
    
    [skillTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardBgView.mas_left).offset(10);
        make.top.mas_equalTo(self.cardBgView.mas_top).offset(10);
    }];
    
    UILabel *skillsLabel = [[UILabel alloc] init];
    [skillsLabel setFont:[UIFont systemFontOfSize:12]];
    [skillsLabel setTextColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [skillsLabel setNumberOfLines:0];
    [self.cardBgView addSubview:skillsLabel];
    self.contentDescLabel = skillsLabel;
    
    [skillsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardBgView.mas_left).offset(10);
        make.top.mas_equalTo(skillTip.mas_bottom).offset(5);
        //make.centerY.mas_equalTo(skillTip.mas_centerY);
        make.right.mas_equalTo(self.cardBgView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-10);
        // make.height.lessThanOrEqualTo(self.cardBgView.mas_bottom).offset(-10);
    }];
}

- (void)loadData:(HWJobBaseInfo *)data
{
    [self.contentDescLabel setText:@"1.  计算机或相关专业本科及以上学历 \
     2.  n年以上IOS开发经验 \
     3.  有自己独立的IOS端产品上线，自己有MAC、iPhone者优先考虑 \
     4.  具体有扎实的Objective-C语言基础，会使用cocos2d-x者优先 \
     5.  熟练掌握IOS开发、测试、调优工具的使用 \
     6.  精通IOS平台自定义控件和动画效果 \
     7.  深入理解Objective-C Runtime运行机制和内存管理机制 \
     8.  深入了解各个不同IOS版本之间的特性与差异 \
     9.  熟悉网络通信机制，熟练使用网络传输协议等 \
     10. 良好的代码习惯，熟练使用常见设计模式，具有一定的数据结构和算法基础，有良好编码风格"];
}

@end
