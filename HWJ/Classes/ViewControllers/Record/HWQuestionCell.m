//
//  HWQuestionCell.m
//  HWJ
//
//  Created by zhiyuan on 16/10/13.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWQuestionCell.h"
#import "UIColor+RGB.h"
#import "Masonry.h"

@interface HWQuestionCell()

@property(nonatomic, strong)UILabel *infoLabel;

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)UIImageView *imgView;

@end

@implementation HWQuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    UIView *bg = [[UIView alloc] initWithFrame:self.frame];
    [self.contentView addSubview:bg];
    self.bgView = bg;
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(2);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-2);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.frame];
    [self.contentView addSubview:label];
    self.infoLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-100);
    }];
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(1);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(1);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-95);
    }];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    self.contentView.clipsToBounds = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.infoLabel.numberOfLines = 0;
    [self.infoLabel setTextAlignment:NSTextAlignmentLeft];
    [self.infoLabel setClipsToBounds:YES];
    
    [self.bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    [self.bgView.layer setCornerRadius:13];
    
    return self;
}

- (void)loadQuestion:(NSString *)question atIndex:(NSInteger)index
{
    NSMutableAttributedString *string = [self getStrWithContent:question atIndex:index];
    [self.infoLabel setAttributedText:string];
}

- (NSMutableAttributedString *)getStrWithContent:(NSString *)str atIndex:(NSInteger)index
{
    NSString *title = [NSString stringWithFormat:@"第%ld题:", index + 1];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", title, str]];
    [result addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
    
    if (self.isLastItem) {
        [result addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(title.length, str.length)];
    }
    else {
        [result addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(title.length, str.length)];
    }
    return result;
}

@end
