//
//  ZYDropView.m
//  TestDrop
//
//  Created by zhiyuan on 16/8/16.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "ZYDropView.h"
#import "Masonry.h"

@interface ZYDropView()

@property (nonatomic, weak)UITableView *table;

@property (nonatomic, strong)UIImageView *headImgView;

@end

@implementation ZYDropView

+ (instancetype)loadHeadInTable:(UITableView *)table height:(CGFloat)height img:(UIImage *)image
{
    ZYDropView *bg = [[ZYDropView alloc] initWithFrame:CGRectMake(0, 0, table.frame.size.width, height)];
    [bg setBackgroundColor:[UIColor whiteColor]];
    table.tableHeaderView = bg;
    bg.table = table;
    
    UIImageView *headImgView = [[UIImageView alloc] initWithImage:image];
    [headImgView setContentMode:UIViewContentModeScaleAspectFill];
    [bg addSubview:headImgView];
    [headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_left);
        make.width.mas_equalTo(bg.mas_width);
        make.bottom.mas_equalTo(bg.mas_bottom);
        make.height.mas_equalTo(bg.table.tableHeaderView.mas_height).offset(MAX(-bg.table.contentOffset.y, 0));
    }];
    bg.headImgView = headImgView;
    
    return bg;
}

- (void)updateFrame
{
    [self.headImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.table.tableHeaderView.mas_left);
        make.width.mas_equalTo(self.table.tableHeaderView.mas_width);
        make.bottom.mas_equalTo(self.table.tableHeaderView.mas_bottom);
        make.height.mas_equalTo(self.table.tableHeaderView.mas_height).offset(MAX(-self.table.contentOffset.y, 0));
    }];
    
}

@end
