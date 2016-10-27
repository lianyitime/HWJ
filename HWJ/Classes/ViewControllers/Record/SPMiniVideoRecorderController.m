//
//  SPMiniVideoRecorderController.m
//  ShiPai
//
//  Created by zhiyuan on 16/9/7.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "SPMiniVideoRecorderController.h"
#import <SCRecorder/SCRecorder.h>
#import "Masonry.h"
#import "SCRecordSessionManager.h"
#import "SCTouchDetector.h"
//#import "SPPublicMiniVideoController.h"
#import "SPLeadProgressView.h"
//#import "VideoAlbumController.h"
#import "BlockAlertView.h"
#import "UIButton+Shadow.h"

#import "SPMiniVideoRecorderController+question.h"

const static float SPMaxVideoTime = 90.;
const static float SPMinVideoTime = 8.;

@interface SPMiniVideoRecorderController()
{
    SCRecorder *_recorder;
    UIImage *_photo;
    SCRecordSession *_recordSession;
    UIImageView *_ghostImageView;
    
}

@property(nonatomic, strong)UIView *previewView;

@property(nonatomic, strong)UIButton *exitBt;

@property (nonatomic, strong)UIButton *toggleBt;

@property (nonatomic, strong)UIButton *flashBt;

@property (nonatomic, strong)UIButton *recordBt;

@property (nonatomic, strong)UIButton *deleteBt;

@property (nonatomic, strong)UIButton *localVideoBt;

@property (nonatomic, strong)UIButton *checkBt;

@property (nonatomic, strong)SPLeadProgressView *progressView;

//@property (nonatomic, strong)UIView *subprogressView;

@property (nonatomic, strong)UIButton *ghostModeButton;

@property (nonatomic, assign)BOOL needStopRender;


@end

@implementation SPMiniVideoRecorderController

- (void)dealloc {
    _recorder.previewView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSubviews];
    
    _recorder = [SCRecorder recorder];
    _recorder.captureSessionPreset = AVCaptureSessionPresetiFrame960x540;//[SCRecorderTools bestCaptureSessionPresetCompatibleWithAllDevices];
    //    _recorder.maxRecordDuration = CMTimeMake(10, 1);
    //    _recorder.fastRecordMethodEnabled = YES;
    _recorder.device = AVCaptureDevicePositionFront;
    _recorder.delegate = self;
    _recorder.autoSetVideoOrientation = NO; //YES causes bad orientation for video from camera roll
    
    UIView *previewView = self.previewView;
    _recorder.previewView = previewView;
    
    _recorder.initializeSessionLazily = NO;
    
    
    
    NSError *error;
    if (![_recorder prepare:&error]) {
        NSLog(@"Prepare error: %@", error.localizedDescription);
    }
}

- (void)loadSubviews
{
    _ghostImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _ghostImageView.contentMode = UIViewContentModeScaleAspectFill;
    _ghostImageView.alpha = 0.2;
    _ghostImageView.userInteractionEnabled = NO;
    _ghostImageView.hidden = YES;
    
    UIView *preview = [[UIView alloc] init];
    [self.view addSubview:preview];
    [preview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height);
        make.center.mas_equalTo(self.view);
    }];
    _previewView = preview;
    
    [self.view insertSubview:_ghostImageView aboveSubview:_previewView];
    
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(self.view);
    }];
    
    SPLeadProgressView *progress = [[SPLeadProgressView alloc] initWithMinTime:SPMinVideoTime Max:SPMaxVideoTime];
    //progress.frame = CGRectMake(0, 0, self.view.frame.size.width, 10);
    //progress.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [preview setBackgroundColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:progress];
    self.progressView = progress;
    
    [progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(10.0);
        make.width.mas_equalTo(self.view.mas_width);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIButton *exitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBt setImage:[UIImage imageNamed:@"icon_short_film_close"] forState:UIControlStateNormal];
    [exitBt addTarget:self action:@selector(onExitBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:exitBt];
    self.exitBt = exitBt;
    
    [exitBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.progressView.mas_bottom).offset(15);
        make.right.mas_equalTo(self.progressView.mas_right).offset(-15);
    }];
    
    UIButton *toggleBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggleBt setImage:[UIImage imageNamed:@"icon_short_film_overturn"] forState:UIControlStateNormal];
    [toggleBt addTarget:self action:@selector(onToggle) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:toggleBt];
    self.toggleBt = toggleBt;
    
    [toggleBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.exitBt.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.exitBt.mas_centerX);
    }];
    
    UIButton *flashBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashBt setImage:[UIImage imageNamed:@"icon_short_film_flashlight"] forState:UIControlStateNormal];
    [flashBt addTarget:self action:@selector(switchFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:flashBt];
    self.flashBt = flashBt;
    
    [flashBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toggleBt.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.exitBt.mas_centerX);
    }];
    
//    UIButton *ghostModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [ghostModeButton setImage:[UIImage imageNamed:@"SPPayResultIcon"] forState:UIControlStateNormal];
//    [ghostModeButton addTarget:self action:@selector(switchGhostMode:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:ghostModeButton];
//    self.ghostModeButton = ghostModeButton;
//    
//    [ghostModeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.flashBt.mas_bottom).offset(15);
//        make.centerX.mas_equalTo(self.exitBt.mas_centerX);
//    }];
    
    
    UIButton *recordBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordBt setBackgroundImage:[UIImage imageNamed:@"btn_photo_photograph"] forState:UIControlStateNormal];
    [recordBt setTitle:@"开始面试" forState:UIControlStateNormal];
    [recordBt setBackgroundImage:[UIImage imageNamed:@"btn_photo_suspend"] forState:UIControlStateSelected];
    [recordBt setTitle:@"面试中" forState:UIControlStateSelected];

    [recordBt addTarget:self action:@selector(pressUpRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:recordBt];
    self.recordBt = recordBt;
    [recordBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    UIButton *deleteBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBt setImage:[UIImage imageNamed:@"icon_short_film_delete_no_pre"] forState:UIControlStateNormal];
    [deleteBt setImage:[UIImage imageNamed:@"icon_short_film_delete_pre"] forState:UIControlStateSelected];
    
    [deleteBt addTarget:self action:@selector(pressedDeleteBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleteBt];
    self.deleteBt = deleteBt;
    
    [deleteBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).multipliedBy(0.5).offset(-100 / 4);
        make.centerY.mas_equalTo(self.recordBt.mas_centerY);
    }];
    
    UIButton *localVideoBt = [UIButton buttonWithType:UIButtonTypeCustom];
    //[localVideoBt setImage:[UIImage imageNamed:@"icon_short_film_import_video"] forState:UIControlStateNormal];
    [localVideoBt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [localVideoBt setShadowTitle:@"测试一下" color:[UIColor grayColor] forState:UIControlStateNormal];
    [localVideoBt addTarget:self action:@selector(pressedLocalVideoBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:localVideoBt];
    self.localVideoBt = localVideoBt;
    
    [localVideoBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.deleteBt);
    }];
    
    UIButton *commitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    //[commitBt setImage:[UIImage imageNamed:@"icon_short_film_ok"] forState:UIControlStateNormal];
    [commitBt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [commitBt setShadowTitle:@"下一题" color:[UIColor grayColor] forState:UIControlStateNormal];
    [commitBt addTarget:self action:@selector(pressCheckVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:commitBt];
    self.checkBt = commitBt;
    
    [commitBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).multipliedBy(1.5).offset(100 / 4);
        make.centerY.mas_equalTo(self.recordBt.mas_centerY);
    }];
    
    self.deleteBt.hidden = YES;
    self.checkBt.hidden  = YES;
}

- (void)recorder:(SCRecorder *)recorder didSkipVideoSampleBufferInSession:(SCRecordSession *)recordSession {
    NSLog(@"Skipped video buffer");
}

- (void)recorder:(SCRecorder *)recorder didReconfigureAudioInput:(NSError *)audioInputError {
    NSLog(@"Reconfigured audio input: %@", audioInputError);
}

- (void)recorder:(SCRecorder *)recorder didReconfigureVideoInput:(NSError *)videoInputError {
    NSLog(@"Reconfigured video input: %@", videoInputError);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self prepareSession];
    
    
    if(!self.needStopRender) {
        [_recorder startRunning];
    }

    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_recorder previewViewFrameChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_recorder stopRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if([self.navigationController.viewControllers containsObject:self]) {
        
    }
    else {
        self.navigationController.navigationBarHidden = NO;
    }
    
}

#pragma mark - Handle

- (void)showAlertViewWithTitle:(NSString*)title message:(NSString*) message {
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)showVideo {
    //SPPublicMiniVideoController *pubVC = [[SPPublicMiniVideoController alloc] initWithSession:_recorder.session];
    //[self.navigationController pushViewController:pubVC animated:YES];
}

- (void)showPhoto:(UIImage *)photo {
    _photo = photo;
    [self performSegueWithIdentifier:@"Photo" sender:self];
}

- (void) handleReverseCameraTapped:(id)sender {
    [_recorder switchCaptureDevices];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSURL *url = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    SCRecordSessionSegment *segment = [SCRecordSessionSegment segmentWithURL:url info:nil];
    
    [_recorder.session addSegment:segment];
    _recordSession = [SCRecordSession recordSession];
    [_recordSession addSegment:segment];
    
    [self showVideo];
}
- (void) handleStopButtonTapped:(id)sender {
    [_recorder pause:^{
        [self saveAndShowSession:_recorder.session];
    }];
}

- (void)saveAndShowSession:(SCRecordSession *)recordSession {
    [[SCRecordSessionManager sharedInstance] saveRecordSession:recordSession];
    
    _recordSession = recordSession;
    [self showVideo];
}

- (void)handleRetakeButtonTapped:(id)sender {
    SCRecordSession *recordSession = _recorder.session;
    
    if (recordSession != nil) {
        _recorder.session = nil;
        
        // If the recordSession was saved, we don't want to completely destroy it
        if ([[SCRecordSessionManager sharedInstance] isSaved:recordSession]) {
            [recordSession endSegmentWithInfo:nil completionHandler:nil];
        } else {
            [recordSession cancelSession:nil];
        }
    }
    
    [self prepareSession];
}

- (void)switchCameraMode:(id)sender {

}

- (void)switchFlash:(id)sender {
    NSString *flashModeString = nil;
    if ([_recorder.captureSessionPreset isEqualToString:AVCaptureSessionPresetPhoto]) {
        switch (_recorder.flashMode) {
            case SCFlashModeAuto:
                //flashModeString = @"Flash : Off";
                _recorder.flashMode = SCFlashModeOff;
                break;
            case SCFlashModeOff:
                //flashModeString = @"Flash : On";
                _recorder.flashMode = SCFlashModeOn;
                break;
            case SCFlashModeOn:
                //flashModeString = @"Flash : Light";
                _recorder.flashMode = SCFlashModeLight;
                break;
            case SCFlashModeLight:
                //flashModeString = @"Flash : Auto";
                _recorder.flashMode = SCFlashModeAuto;
                break;
            default:
                break;
        }
    } else {
        switch (_recorder.flashMode) {
            case SCFlashModeOff:
                //flashModeString = @"Flash : On";
                _recorder.flashMode = SCFlashModeLight;
                break;
            case SCFlashModeLight:
                //flashModeString = @"Flash : Off";
                _recorder.flashMode = SCFlashModeOff;
                break;
            default:
                break;
        }
    }
    
    [self.flashBt setTitle:flashModeString forState:UIControlStateNormal];
}

- (void)onToggle
{
    AVCaptureDevicePosition position  = _recorder.device;
    if (position == AVCaptureDevicePositionBack) {
        _recorder.device = AVCaptureDevicePositionFront;
        self.flashBt.hidden = YES;
    }
    else {
        _recorder.device = AVCaptureDevicePositionBack;
        self.flashBt.hidden = NO;
    }
}

- (void)prepareSession {
    if (_recorder.session == nil) {
        
        SCRecordSession *session = [SCRecordSession recordSession];
        session.fileType = AVFileTypeQuickTimeMovie;
        
        _recorder.session = session;
    }
    
    //[self updateTimeRecordedLabel];
    [self updateGhostImage];
}

- (void)recorder:(SCRecorder *)recorder didCompleteSession:(SCRecordSession *)recordSession {
    NSLog(@"didCompleteSession:");
    [self saveAndShowSession:recordSession];
}

- (void)recorder:(SCRecorder *)recorder didInitializeAudioInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    if (error == nil) {
        NSLog(@"Initialized audio in record session");
    } else {
        NSLog(@"Failed to initialize audio in record session: %@", error.localizedDescription);
    }
}

- (void)recorder:(SCRecorder *)recorder didInitializeVideoInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    if (error == nil) {
        NSLog(@"Initialized video in record session");
    } else {
        NSLog(@"Failed to initialize video in record session: %@", error.localizedDescription);
    }
}

- (void)recorder:(SCRecorder *)recorder didBeginSegmentInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    NSLog(@"Began record segment: %@", error);
}

- (void)recorder:(SCRecorder *)recorder didCompleteSegment:(SCRecordSessionSegment *)segment inSession:(SCRecordSession *)recordSession error:(NSError *)error {
    NSLog(@"Completed record segment at %@: %@ (frameRate: %f)", segment.url, error, segment.frameRate);
    [self updateGhostImage];
}

- (void)updateTimeRecordedLabel {
    CMTime currentTime = kCMTimeZero;
    
    if (_recorder.session != nil) {
        currentTime = _recorder.session.duration;
    }
    float time = CMTimeGetSeconds(currentTime);
    [self.progressView updateProgress:time];
    if (time < SPMinVideoTime) {
        self.checkBt.hidden = YES;
    }
    else {
        if (![self.recordBt isSelected]) {
            self.checkBt.hidden = NO;
            self.checkBt.enabled = YES;
        }
        else {
            self.checkBt.hidden = NO;
            self.checkBt.enabled = NO;
        }
        if(time >= SPMaxVideoTime && _recorder.isRecording) {
            
            __weak SPMiniVideoRecorderController *ws = self;
            [self pauseRecord:^{
                [ws pressCheckVideo:nil];
                ws.checkBt.hidden = NO;
                ws.recordBt.selected = NO;
            }];
        }
    }

}

- (void)recorder:(SCRecorder *)recorder didAppendVideoSampleBufferInSession:(SCRecordSession *)recordSession {
    [self updateTimeRecordedLabel];
}

//- (void)handleTouchDetected:(SCTouchDetector*)touchDetector {
//    if (touchDetector.state == UIGestureRecognizerStateBegan) {
//        _ghostImageView.hidden = YES;
//        [_recorder record];
//        
//    } else if (touchDetector.state == UIGestureRecognizerStateEnded) {
//        [_recorder pause];
//    }
//}

- (void)pressUpRecord:(UIButton *)sender
{
    if (sender.isSelected) {
        //[_recorder pause];
        sender.selected = !sender.isSelected;
        [self pauseRecord:nil];
        
    }
    else {
//        [_recorder record];
//        [self.progressView resumeProgress];
        sender.selected = !sender.isSelected;
        [self startRecord];
        [self startLoadQuestion:^(NSError *error) {
            
        }];

    }

}

- (void)pauseRecord:(void(^)())completionHandler
{
    [_recorder pause:completionHandler];
    [self updateTimeRecordedLabel];

    self.deleteBt.hidden = NO;
    
    
    self.exitBt.hidden = NO;
    self.toggleBt.hidden = NO;
    self.flashBt.hidden = NO;
}

- (void)startRecord
{
    [_recorder record];
    [self.progressView resumeProgress];
    self.deleteBt.selected = NO;
    
    self.deleteBt.hidden = YES;
    self.checkBt.hidden  = YES;
    
    self.localVideoBt.hidden = YES;
    
    self.exitBt.hidden = YES;
    self.toggleBt.hidden = YES;
    self.flashBt.hidden = YES;
    
    //1s后才可以暂停，每次至少录1s
    self.recordBt.enabled = NO;
    [self performSelector:@selector(enableRecord) withObject:nil afterDelay:0.1];
}

- (void)enableRecord
{
    [self.recordBt setEnabled:YES];
}

- (void)pressCheckVideo:(id)sender
{
    self.checkBt.enabled = NO;
    self.checkBt.selected = !self.checkBt.isSelected;
    
    [_recorder pause:^{
        [self saveAndShowSession:_recorder.session];
        self.checkBt.enabled = YES;

    }];
}

- (void)pressedDeleteBt:(UIButton *)sender
{
    SCRecordSession *recordSession = _recorder.session;
    if (recordSession.segments.count > 0) {
        if ([self.progressView isSelected]) {
            [recordSession removeSegmentAtIndex:recordSession.segments.count - 1 deleteFile:YES];
            [self updateTimeRecordedLabel];
            [self.progressView removeLastPart];
            
            if (recordSession.segments.count == 0) {
                self.deleteBt.hidden = YES;
                self.localVideoBt.hidden = NO;
            }
        }
        else {
            [self.progressView selectLastPart];
        }

    }
    
    sender.selected = [self.progressView isSelected];
    
}

- (void)pressedLocalVideoBt:(UIButton *)sender
{
//    [_recorder stopRunning];
//    
//    VideoAlbumController *vc = [[VideoAlbumController alloc] init];
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)capturePhoto:(id)sender {
    [_recorder capturePhoto:^(NSError *error, UIImage *image) {
        if (image != nil) {
            [self showPhoto:image];
        } else {
            [self showAlertViewWithTitle:@"Failed to capture photo" message:error.localizedDescription];
        }
    }];
}

- (void)updateGhostImage {
    UIImage *image = nil;
    
    if (_ghostModeButton.selected) {
        if (_recorder.session.segments.count > 0) {
            SCRecordSessionSegment *segment = [_recorder.session.segments lastObject];
            image = segment.lastImage;
        }
    }
    
    
    _ghostImageView.image = image;
    //    _ghostImageView.image = [_recorder snapshotOfLastAppendedVideoBuffer];
    _ghostImageView.hidden = !_ghostModeButton.selected;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)switchGhostMode:(id)sender {
    _ghostModeButton.selected = !_ghostModeButton.selected;
    _ghostImageView.hidden = !_ghostModeButton.selected;
    
    [self updateGhostImage];
}
- (void)toolsButtonTapped:(UIButton *)sender {
//    CGRect toolsFrame = self.toolsContainerView.frame;
//    CGRect openToolsButtonFrame = self.openToolsButton.frame;
//    
//    if (toolsFrame.origin.y < 0) {
//        sender.selected = YES;
//        toolsFrame.origin.y = 0;
//        openToolsButtonFrame.origin.y = toolsFrame.size.height + 15;
//    } else {
//        sender.selected = NO;
//        toolsFrame.origin.y = -toolsFrame.size.height;
//        openToolsButtonFrame.origin.y = 15;
//    }
//    
//    [UIView animateWithDuration:0.15 animations:^{
//        self.toolsContainerView.frame = toolsFrame;
//        self.openToolsButton.frame = openToolsButtonFrame;
//    }];
}
- (void)closeCameraTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onExitBt:(id)sender
{
    if (_recorder.session.segments.count > 0) {
        BlockAlertView *alert = [[BlockAlertView alloc] initWithTitle:@"退出录制" message:@"确定现在退出小视频录制?" clickBlock:^(int index) {
            if(index == 0) {
                [_recorder stopRunning];
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        } cancelButtonTitle:@"确定" otherButtonTitle:@"取消"];
        
        [alert show];
    }
    else {
        //[self.navigationController popViewControllerAnimated:YES];
        [_recorder stopRunning];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }

}



@end
