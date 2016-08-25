//
//  HWCandidateDetailEducation.m
//  HWJ
//
//  Created by zhiyuan on 16/8/25.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWCandidateDetailEducation.h"

@interface HWCandidateDetailEducation()

//江西师大|软件工程|本科|09届
@property(nonatomic, strong)UILabel *collage;

@end

@implementation HWCandidateDetailEducation

- (void)loadSubviews
{
    [super loadSubviews];
    UILabel *collage = [[UILabel alloc] init];
    [collage setFont:[UIFont systemFontOfSize:12]];
    [collage setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:collage];
    self.collage = collage;
    
    [collage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardBgView.mas_left).offset(15);
        make.right.mas_equalTo(self.cardBgView.mas_right).offset(-15);
        make.top.mas_equalTo(self.cardBgView.mas_top).offset(15);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-15);
    }];
}

- (void)loadData:(HWCandidateInfo *)data
{
    [self.collage setText:[NSString stringWithFormat:@"%@|%@|%@", data.collageName, data.subcollageName, data.collageLevel]];
}

@end
