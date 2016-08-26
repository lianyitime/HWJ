//
//  HWCandidateBlogCell.m
//  HWJ
//
//  Created by zhiyuan on 16/8/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWCandidateBlogCell.h"

@interface HWCandidateBlogCell()

@property (nonatomic, strong)UIButton *blogBt;

@end

@implementation HWCandidateBlogCell

- (void)loadSubviews
{
    [super loadSubviews];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    [tipLabel setFont:[UIFont systemFontOfSize:12]];
    [tipLabel setTextColor:[UIColor grayColor]];
    [self.cardBgView addSubview:tipLabel];
    [tipLabel setText:@"技术博客:"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardBgView.mas_left).offset(15);
        make.top.mas_equalTo(self.cardBgView.mas_top).offset(15);
    }];
    
    UIButton *blog = [UIButton buttonWithType:UIButtonTypeCustom];
    [blog setTitleColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
    [blog.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [blog setContentMode:UIViewContentModeScaleToFill];
    [blog setImage:[UIImage imageNamed:@"github"] forState:UIControlStateNormal];
    [blog addTarget:self action:@selector(onSelectedBlog:) forControlEvents:UIControlEventTouchUpInside];
    [self.cardBgView addSubview:blog];
    self.blogBt = blog;
    [blog mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipLabel.mas_right).offset(5);
        //make.centerX.mas_equalTo(self.cardBgView.mas_centerX);
        make.height.mas_equalTo (20);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(tipLabel.mas_centerY);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-15);

    }];
}

- (void)loadData:(HWCandidateInfo *)data
{
    //[self.blogBt setTitle:data.blogType forState:UIControlStateNormal];
    
}


@end
