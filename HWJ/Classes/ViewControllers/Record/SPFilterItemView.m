//
//  SPFilterItemView.m
//  ShiPai
//
//  Created by zhiyuan on 16/9/19.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "SPFilterItemView.h"
#import "Masonry.h"
#import "UIColor+RGB.h"

@interface SPFilterItemView()

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation SPFilterItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self loadSubviews];
    return self;
}

- (void)loadSubviews
{
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self);
        make.center.mas_equalTo(self);
    }];
    self.imageView = imgView;
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:10]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [self addSubview:label];
    self.titleLabel = label;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(16.);
    }];
}

- (void)setItemSelected:(BOOL)selected
{
    if (selected) {
        self.layer.borderColor = [UIColor colorWithRGBHex:0xffcd02].CGColor;
        self.layer.borderWidth = 2.;
    }
    else {
        self.layer.borderWidth = 0.;
    }
}

- (void)setImage:(UIImage *)image
{
    [self.imageView setImage:image];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
