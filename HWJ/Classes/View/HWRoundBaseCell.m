//
//  HWRoundBaseCell.m
//  HWJ
//
//  Created by zhiyuan on 16/8/24.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWRoundBaseCell.h"

@implementation HWRoundBaseCell

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

}
@end
