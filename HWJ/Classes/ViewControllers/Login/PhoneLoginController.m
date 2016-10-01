//
//  PhoneLoginController.m
//  ShiPai
//
//  Created by duyu-mac on 16/5/8.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "PhoneLoginController.h"
#import "MBProgressHUD+MJ.h"
#import "UIButton+WebCache.h"
#import "HWInterfaceDef.h"
#import "HWFrameSet.h"
#import "RTAlbumsManager.h"
#import "HWLoginSetUserController.h"
#import "HWLoginComparySetController.h"
//#import "CTRouteManager.h"
@interface PhoneLoginController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int nextAuthTime;

@property (strong, nonatomic) IBOutlet UITableViewCell *phoneCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *imageCodeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *authCodeCell;

@property (weak, nonatomic) IBOutlet UIView *phoneContainerView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIView *imageCodeContainer;
@property (weak, nonatomic) IBOutlet UITextField *imageCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *imageCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *authCodeTextField;
@property (weak, nonatomic) IBOutlet UIView *authCodeContainer;
@property (weak, nonatomic) IBOutlet UIButton *authCodeButton;

@property (nonatomic, assign) BOOL isNeedImageAuth;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (nonatomic, strong) NSArray *textFields;

@property (nonatomic, strong) UIView *starIconAccessoryView;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong)UIView *selectView;
@end

@implementation PhoneLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = self.footerView;
    
    self.phoneContainerView.layer.borderColor = RGB16(0x737373).CGColor;
    self.phoneContainerView.layer.borderWidth = 0.5;
 
    self.authCodeContainer.layer.borderColor = RGB16(0x737373).CGColor;
    self.authCodeContainer.layer.borderWidth = 0.5;
    
    self.imageCodeContainer.layer.borderColor = RGB16(0x737373).CGColor;
    self.imageCodeContainer.layer.borderWidth = 0.5;
    
    self.authCodeButton.layer.borderColor = RGB16(0x737373).CGColor;
    self.authCodeButton.layer.borderWidth = 0.5;
    
    self.title = @"登录";
    // Do any additional setup after loading the view from its nib.
    
//    self.phoneTextField.inputAccessoryView = self.starIconAccessoryView;
//    self.imageCodeTextField.inputAccessoryView = self.starIconAccessoryView;
//    self.authCodeTextField.inputAccessoryView = self.starIconAccessoryView;
    
    self.textFields = @[self.phoneTextField, self.imageCodeTextField, self.authCodeTextField];
    
//    self.navigationItem.backBarButtonItem = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    [self.tableView addGestureRecognizer:self.tap];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    [self.tableView removeGestureRecognizer:self.tap];
}

- (void)hideKeyBoard
{
    [self.view endEditing:YES];
}

- (UITapGestureRecognizer *)tap
{
    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    }
    
    return _tap;

}

- (void)updateImageCode
{
    
    self.activityView.hidden = NO;
    [self.activityView  startAnimating];
    [self.imageCodeButton setImage:nil forState:UIControlStateNormal];
    NSString *imageUrl = [NSString stringWithFormat:@"%@?%d", URL_GET_CAPTCHA, arc4random_uniform(1000)];

    [self.imageCodeButton sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageHandleCookies completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        [self.imageCodeButton setTitle:nil forState:UIControlStateNormal];
        self.activityView.hidden = YES;
        [self.activityView  stopAnimating];
        self.imageCodeButton.backgroundColor = [UIColor whiteColor];
        [self.imageCodeTextField becomeFirstResponder];
        self.imageCodeTextField.text = nil;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)waitAuthCode:(int)duration
{
    //倒计时
    self.authCodeButton.enabled = false;
    self.authCodeButton.backgroundColor = RGB16(COLOR_BG_GRAY);
    [self.authCodeButton setTitleColor:RGB16(COLOR_FONT_LIGHTGRAY) forState:UIControlStateNormal];
    self.nextAuthTime = duration;
    [self.authCodeButton setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)self.nextAuthTime] forState:UIControlStateDisabled];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(authTick) userInfo:nil repeats:YES];
}

- (void)authTick
{
    self.nextAuthTime = self.nextAuthTime - 1;
    if(self.nextAuthTime == 0)
    {
        [self.timer invalidate];
        self.timer = nil;
        self.authCodeButton.enabled = true;
        [self.authCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        [self.authCodeButton setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)self.nextAuthTime] forState:UIControlStateDisabled];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1 && !self.isNeedImageAuth) {
        return 0;
    }
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return  self.phoneCell;
    }else if (indexPath.row == 1){
        return self.imageCodeCell;
    }else{
        return self.authCodeCell;
    }
}
- (IBAction)imageCodeButtonClick:(id)sender {
    
    [self updateImageCode];
}
- (IBAction)authCodeButtonClick:(id)sender {
    
    if (self.isNeedImageAuth && self.imageCodeTextField.text == nil) {
        [MBProgressHUD showTipsMessage:@"请输入图片验证码" toView:self.view];
        return;
    }
    
    if (self.phoneTextField.text == nil || [self.phoneTextField.text isEqualToString: @""]) {
        [MBProgressHUD showTipsMessage:@"请输入手机号" toView:self.view];
        return;
    }
    
    if (self.phoneTextField.text.length > 11) {
        [MBProgressHUD showTipsMessage:@"手机号不能大于11位" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMessage:@"请稍后" toView:self.view];
    [[RTAlbumsManager sharedInstance] loadMobleAuthCodeWithPhone:self.phoneTextField.text needExistAccount:NO withBlock:^(BOOL success, id responseObject, NSError *error) {
        if (success) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showTipsMessage:@"验证码已发送" toView:self.view];
            [self.authCodeTextField becomeFirstResponder];
            [self waitAuthCode:60];
        }
        else {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            BOOL isNeedRefresh = YES;
            
//            if ([error. isEqualToString:@"500115"]) { // 需要图片验证码
//                self.isNeedImageAuth = YES;
//                [self.tableView reloadData];
//                [MBProgressHUD showTipsMessage:@"请输入图片验证码" toView:self.view];
//            }else if ([error isEqualToString:@"403004"]){
//                isNeedRefresh = YES;
//                [MBProgressHUD showTipsMessage:@"图片验证码错误" toView:self.view];
//            }else if ([error isEqualToString:@"500117"]){
//                [MBProgressHUD showTipsMessage:@"手机号无效" toView:self.view];
//            }else if ([error isEqualToString:@"500109"]){
//                [MBProgressHUD showTipsMessage:@"短信发送太频繁了，请稍后重试" toView:self.view];
//            }else if ([error isEqualToString:@"500110"]){
//                isNeedRefresh = NO;
//                [MBProgressHUD showTipsMessage:@"短信发送太多了，请一个小时后重试" toView:self.view];
//            }else{
//                [MBProgressHUD showTipsMessage:@"获取验证码失败" toView:self.view];
//            }
            
            if (isNeedRefresh) {
                self.imageCodeTextField.text = nil;
                [self updateImageCode];
            }
        }
        
    }];
    
}

- (IBAction)loginButtonClick:(id)sender {
//    [self onLogin:sender];
//    return;
    
    if (self.phoneTextField.text == nil || [self.phoneTextField.text isEqualToString:@""]) {
        [MBProgressHUD showTipsMessage:@"请输入手机号" toView:self.view];
        return;
    }
    
    if (self.phoneTextField.text.length > 11) {
        [MBProgressHUD showTipsMessage:@"手机号不能大于11位" toView:self.view];
        return;
    }
    
    if ((self.imageCodeTextField.text == nil || [self.imageCodeTextField.text isEqualToString:@""]) && self.isNeedImageAuth) {
        [MBProgressHUD showTipsMessage:@"请输入图片验证码" toView:self.view];
        return;
    }
    
    if (self.authCodeTextField.text == nil || [self.authCodeTextField.text isEqualToString:@""]) {
        [MBProgressHUD showTipsMessage:@"请输入验证码" toView:self.view];
        return;
    }
    
    [MBProgressHUD showMessage:@"登录中..." toView:self.view];

    [[RTAlbumsManager sharedInstance] loginWtihAuthCode:self.phoneTextField.text withCode:self.authCodeTextField.text withBlock:^(BOOL success, id responseObject, NSError *error) {
        if (success) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([self.delegate respondsToSelector:@selector(phoneLoginController:didLoginWithUserInfo:)]) {
                [self.delegate phoneLoginController:self didLoginWithUserInfo:responseObject];
            }
        }
        else {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showTipsMessage:@"登录失败" toView:self.view];
        }
    }];
 
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.imageCodeTextField) {
        [self.authCodeTextField becomeFirstResponder];
    }
    
    
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTextField) {
        
        
        if (textField.text.length > 10 && range.length <= 0) {
            return NO;
        }
        
        
    }else if (textField == self.authCodeTextField){
        
        if (textField.text.length > 5 && range.length <= 0) {
            return NO;
        }

    }
    
    return YES;
}

- (IBAction)agreeButtonClick:(id)sender {
    
    //[[CTRouteManager sharedInstance] handleUrl:@"http://d.xpai.tv/legal/eua.html"];
}

- (UIView *)starIconAccessoryView
{
    if (!_starIconAccessoryView) {
        UIView *accessoryView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        accessoryView.backgroundColor = [UIColor whiteColor];
        
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        topLine.backgroundColor = RGBColor(221, 227, 237);
        
        UIButton *btnCancel = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        btnCancel.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [btnCancel setTitleColor:RGBColor(45, 45, 45) forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btnCancel addTarget:self action:@selector(starInputCancleClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnConfirm = [[UIButton alloc]initWithFrame:CGRectMake( SCREEN_WIDTH - 50, 0, 40, 40)];
        [btnConfirm setTitle:@"完成" forState:UIControlStateNormal];
        [btnConfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        btnConfirm.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [btnConfirm addTarget:self action:@selector(starInputConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, accessoryView.frame.size.height - 0.5, SCREEN_WIDTH, 0.5)];
        bottomLine.backgroundColor = RGBColor(221, 227, 237);
        
        [accessoryView addSubview:topLine];
        [accessoryView addSubview:btnCancel];
        [accessoryView addSubview:btnConfirm];
        [accessoryView addSubview:bottomLine];
        _starIconAccessoryView = accessoryView;
    }
    return _starIconAccessoryView;
}


- (void)selectNextTextField
{
    for (int i = 0; i < self.textFields.count; i++) {
        
        UITextField *textField = self.textFields[i];
        
        if ([textField isFirstResponder] && i < self.textFields.count - 1) {
            [textField resignFirstResponder];
            UITextField *next = self.textFields[i + 1];
            
            
            
            [next becomeFirstResponder];
            break;
            
        }else{
            [self.view endEditing:YES];
        }
        
        
    }
}

- (void)starInputCancleClick
{
    [self.view endEditing:YES];
}

- (void)starInputConfirmClick
{
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onLogin:(UIButton *)sender
{
    CGRect frame = self.view.bounds;
    frame.origin.y += frame.size.height;
    UIView *selectView = [[UIView alloc] initWithFrame:frame];
    [selectView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    self.selectView = selectView;
    [self.view addSubview:selectView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, mainSize.height / 2 - 120, self.view.frame.size.width, 50)];
    [label setText:@"选择角色"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:18]];
    [label setTextColor:[UIColor whiteColor]];
    [self.selectView addSubview:label];
    
    UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt1.frame = CGRectMake(30, mainSize.height / 2 - 50, mainSize.width - 60, 40);
    [bt1 setClipsToBounds:YES];
    [bt1.layer setCornerRadius:40.0 / 2];
    [bt1 setBackgroundColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [bt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt1 setTitle:@"我要求职" forState:UIControlStateNormal];
    [bt1 addTarget:self action:@selector(onFindJob:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectView addSubview:bt1];
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt2.frame = CGRectMake(30, mainSize.height / 2 + 20, mainSize.width - 60, 40);
    [bt2 setClipsToBounds:YES];
    [bt2.layer setCornerRadius:40.0 / 2];
    [bt2 setBackgroundColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt2 setTitle:@"我要招聘" forState:UIControlStateNormal];
    [bt2 addTarget:self action:@selector(onCompanyBt:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectView addSubview:bt2];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.selectView.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)onFindJob:(UIButton *)sender
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:HWUSER_LOGIN_FINISHED object:nil];
    HWLoginSetUserController *vc = [[HWLoginSetUserController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:^{
        
    }];
    
    [self.selectView removeFromSuperview];
}

- (void)onCompanyBt:(UIButton *)sender
{
    [self.selectView removeFromSuperview];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:HWUSER_LOGIN_FINISHED object:nil];
    HWLoginComparySetController *vc = [[HWLoginComparySetController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:^{
        
    }];
}

@end
