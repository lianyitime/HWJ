//
//  ViewController.m
//  JxbLovelyLogin
//
//  Created by Peter on 15/8/11.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "HWLoginViewController.h"
#import "HWNotificationDef.h"
#import "HWLoginSetUserController.h"
#import "HWLoginComparySetController.h"

#import "HWFrameSet.h"
#import "HWUsersManager.h"


#define offsetLeftHand      60

#define rectLeftHand        CGRectMake(61-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(mainSize.width / 2 - 100, vLogin.frame.origin.y - 22, 40, 40)

#define rectRightHand       CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(mainSize.width / 2 + 62, vLogin.frame.origin.y - 22, 40, 40)

@interface HWLoginViewController ()<UITextFieldDelegate>
{
    UITextField* txtUser;
    UITextField* txtPwd;
    
    UIImageView* imgLeftHand;
    UIImageView* imgRightHand;
    
    UIImageView* imgLeftHandGone;
    UIImageView* imgRightHandGone;
    
    JxbLoginShowType showType;
}

@property (nonatomic, strong)UIScrollView *contentView;

@property (nonatomic, strong)UIButton *loginBt;

@property (nonatomic, strong)UIView *selectView;

@end

@implementation HWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [contentView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ontTap:)];
    [self.contentView addGestureRecognizer:tap];
 
    UIImageView* imgLogin = [[UIImageView alloc] initWithFrame:CGRectMake(mainSize.width / 2 - 211 / 2, 100, 211, 109)];
    imgLogin.image = [UIImage imageNamed:@"owl-login"];
    imgLogin.layer.masksToBounds = YES;
    [self.contentView addSubview:imgLogin];
    
    imgLeftHand = [[UIImageView alloc] initWithFrame:rectLeftHand];
    imgLeftHand.image = [UIImage imageNamed:@"owl-login-arm-left"];
    [imgLogin addSubview:imgLeftHand];
    
    imgRightHand = [[UIImageView alloc] initWithFrame:rectRightHand];
    imgRightHand.image = [UIImage imageNamed:@"owl-login-arm-right"];
    [imgLogin addSubview:imgRightHand];

    UIView* vLogin = [[UIView alloc] initWithFrame:CGRectMake(15, 200, mainSize.width - 30, 160)];
    vLogin.layer.borderWidth = 0.5;
    vLogin.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    vLogin.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:vLogin];
    
    imgLeftHandGone = [[UIImageView alloc] initWithFrame:rectLeftHandGone];
    imgLeftHandGone.image = [UIImage imageNamed:@"icon_hand"];
    [self.contentView addSubview:imgLeftHandGone];
    
    imgRightHandGone = [[UIImageView alloc] initWithFrame:rectRightHandGone];
    imgRightHandGone.image = [UIImage imageNamed:@"icon_hand"];
    [self.contentView addSubview:imgRightHandGone];
    
    txtUser = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, vLogin.frame.size.width - 60, 44)];
    txtUser.placeholder = @"输入手机号";
    txtUser.delegate = self;
    txtUser.layer.cornerRadius = 44 / 2;
    txtUser.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    txtUser.layer.borderWidth = 0.5;
    txtUser.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    txtUser.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    [txtUser.leftView addSubview:imgUser];
    [vLogin addSubview:txtUser];
    
    txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, vLogin.frame.size.width - 60, 44)];
    txtPwd.placeholder = @"输入密码";
    txtPwd.delegate = self;
    txtPwd.layer.cornerRadius = 44 / 2;
    txtPwd.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    txtPwd.layer.borderWidth = 0.5;
    txtPwd.secureTextEntry = YES;
    txtPwd.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    txtPwd.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
    [txtPwd.leftView addSubview:imgPwd];
    [vLogin addSubview:txtPwd];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(30, vLogin.frame.origin.y + vLogin.frame.size.height + 30, mainSize.width - 60, 40);
    [login setClipsToBounds:YES];
    [login.layer setCornerRadius:40.0 / 2];
    [login setBackgroundColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:login];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:txtUser]) {
        if (showType != JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_USER;
            return;
        }
        showType = JxbLoginShowType_USER;
        [UIView animateWithDuration:0.5 animations:^{
            imgLeftHand.frame = CGRectMake(imgLeftHand.frame.origin.x - offsetLeftHand, imgLeftHand.frame.origin.y + 30, imgLeftHand.frame.size.width, imgLeftHand.frame.size.height);
            
            imgRightHand.frame = CGRectMake(imgRightHand.frame.origin.x + 48, imgRightHand.frame.origin.y + 30, imgRightHand.frame.size.width, imgRightHand.frame.size.height);
            
            
            imgLeftHandGone.frame = CGRectMake(imgLeftHandGone.frame.origin.x - 70, imgLeftHandGone.frame.origin.y, 40, 40);
            
            imgRightHandGone.frame = CGRectMake(imgRightHandGone.frame.origin.x + 30, imgRightHandGone.frame.origin.y, 40, 40);
         
            
        } completion:^(BOOL b) {
        }];

    }
    else if ([textField isEqual:txtPwd]) {
        if (showType == JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_PASS;
            return;
        }
        showType = JxbLoginShowType_PASS;
        [UIView animateWithDuration:0.5 animations:^{
            imgLeftHand.frame = CGRectMake(imgLeftHand.frame.origin.x + offsetLeftHand, imgLeftHand.frame.origin.y - 30, imgLeftHand.frame.size.width, imgLeftHand.frame.size.height);
            imgRightHand.frame = CGRectMake(imgRightHand.frame.origin.x - 48, imgRightHand.frame.origin.y - 30, imgRightHand.frame.size.width, imgRightHand.frame.size.height);
            
            
            imgLeftHandGone.frame = CGRectMake(imgLeftHandGone.frame.origin.x + 70, imgLeftHandGone.frame.origin.y, 0, 0);
            
            imgRightHandGone.frame = CGRectMake(imgRightHandGone.frame.origin.x - 30, imgRightHandGone.frame.origin.y, 0, 0);

        } completion:^(BOOL b) {
        }];
    }
}

#pragma mark - 键盘通知
- (void)keyboardWasShown:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    //CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self.contentView setContentOffset:CGPointMake(0, 60)];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    [self.contentView setContentOffset:CGPointMake(0, 0)];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)ontTap:(UITapGestureRecognizer *)tap
{
    if (txtUser.isFirstResponder) {
        [txtUser endEditing:YES];
    }
    if (txtPwd.isFirstResponder) {
        [txtPwd endEditing:YES];
    }
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
    
    HWUserProfile *user = [[HWUserProfile alloc] init];
    user.account = txtUser.text;
    [HWUsersManager sharedInstance].currentUser = user;
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
