//
//  HWJVideoPlayerController.m
//  HWJ
//
//  Created by zhiyuan on 16/10/25.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "HWJVideoPlayerController.h"
#import <SCRecorder/SCVideoPlayerView.h>
#import "Masonry.h"

@interface HWJVideoPlayerController()

@property (nonatomic, strong)SCVideoPlayerView *player;

@end

@implementation HWJVideoPlayerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    SCPlayer *player = [SCPlayer player];
    SCVideoPlayerView *playerView = [[SCVideoPlayerView alloc] initWithPlayer:player];
    playerView.frame = self.view.bounds;
    [self.view addSubview:playerView];
    
    [playerView.player setItemByUrl:[NSURL URLWithString:@"http://svideo-10039883.file.myqcloud.com/5d384c7320c1fc8188ec72d0db8083e8.mp4"]];
    
    [playerView.player play];
    
    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBt setTitle:@"返回" forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
    
    [backBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20.);
        make.top.mas_offset(20.);
    }];
}

- (void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
