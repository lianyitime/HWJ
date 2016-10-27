//
//  HWPdfReviewCell.m
//  HWJ
//
//  Created by zhiyuan on 16/10/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWPdfReviewCell.h"
#import <WebKit/WebKit.h>

@implementation HWPdfReviewCell

- (void)loadSubviews
{
    [super loadSubviews];
    
    WKWebView *webView = [[WKWebView alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"review.pdf" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.cardBgView addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardBgView.mas_left).offset(5);
        make.centerX.mas_equalTo(self.cardBgView);
        make.centerY.mas_equalTo(self.cardBgView.mas_centerY);
        make.bottom.mas_equalTo(self.cardBgView.mas_bottom).offset(-5);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height - 49 - 44 - 70);
        
    }];

}
@end
