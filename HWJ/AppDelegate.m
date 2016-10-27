//
//  AppDelegate.m
//  HWJ
//
//  Created by zhiyuan on 16/7/26.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "AppDelegate.h"
#import "HWNotificationDef.h"
#import "HWCandidatesListController.h"
#import "HWJosbListController.h"
#import "HWSettingController.h"
#import "HWMsgsListController.h"
#import "EMSDK.h"
#import "EaseUI.h"
#import "HWNavigationViewController.h"
#import "HWRecommendJobsListController.h"
#import "ConversationListController.h"
#import "HWProcessListController.h"
#import "HWJobsManagerController.h"

#import "PhoneLoginController.h"
#import "HWLoginViewController.h"

@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLogin:) name:HWUSER_LOGIN_FINISHED object:nil];
    
    [self regiestServices];
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:@"douser#istore"
                                         apnsCertName:@"istore_dev"
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    if ([self canAutoLogin]) {
        
    }
    else {
        //[self performSelector:@selector(loadPhoneLogin) withObject:nil afterDelay:2.];
        HWLoginViewController *loginVC = [[HWLoginViewController alloc] init];
        self.window.rootViewController = loginVC;

    }
    
    return YES;
}

- (BOOL)canAutoLogin
{
    return NO;
}

- (void)loadPhoneLogin
{
    PhoneLoginController *login = [[PhoneLoginController alloc] initWithNibName:@"PhoneLoginController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = navi;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)regiestServices
{
    //注册环信
    EMOptions *options = [EMOptions optionsWithAppkey:@"zhiyuanily#helloworldj"];
    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //添加回调监听代理:
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
}

- (void)loginUserIM
{
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:@"zhiyuan123" password:@"111111"];
        if (!error)
        {
            NSLog(@"登录IM成功");
            [[EMClient sharedClient].options setIsAutoLogin:YES];
        }
        else if((error.code == EMErrorUserNotFound)){
            EMError *error = [[EMClient sharedClient] registerWithUsername:@"zhiyuan123" password:@"111111"];
            if (error==nil) {
                NSLog(@"注册IM成功");
                [self loginUserIM];
            }
            else {
                NSLog(@"注册IM失败");
            }
        }
        else {
            NSLog(@"登录IM失败");
        }
    }
}

#pragma mark - EMClientDelegate

- (void)didAutoLoginWithError:(EMError *)aError;
{
    if (!aError) {
        NSLog(@"自动登录IM成功");
    }
}

- (void)didLoginFromOtherDevice;
{
    
}

- (void)didRemovedFromServer
{
    
}

- (void)onLogin:(NSNotification *)notification
{
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0]];
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    
    
    NSString *flag = notification.object;
    if ([flag isKindOfClass:[NSString class]] && [flag isEqualToString:@"user"])  {
        HWJosbListController *jobsVC = [[HWJosbListController alloc] init];
        jobsVC.title = @"机会";
        jobsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"机会" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];
        HWNavigationViewController *navi1 = [[HWNavigationViewController alloc] initWithRootViewController:jobsVC];
        
        HWRecommendJobsListController *recommendVC = [[HWRecommendJobsListController alloc] init];
        recommendVC.title = @"面试";
        recommendVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"面试" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];
        HWNavigationViewController *navi = [[HWNavigationViewController alloc] initWithRootViewController:recommendVC];
        
        ConversationListController *chatListVC = [[ConversationListController alloc] init];
        chatListVC.title = @"消息";
        chatListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];
        
        HWNavigationViewController *nav2 = [[HWNavigationViewController alloc] initWithRootViewController:chatListVC];
        
        HWSettingController *setVC = [[HWSettingController alloc] init];
        setVC.title = @"我的";
        setVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];
        
        HWNavigationViewController *nav3 = [[HWNavigationViewController alloc] initWithRootViewController:setVC];
        
        tabController.viewControllers = @[navi1, navi, nav2, nav3];
    }
    else {
        HWCandidatesListController *candiVC = [[HWCandidatesListController alloc] init];
        candiVC.title = @"候选人";
        HWNavigationViewController *navi1 = [[HWNavigationViewController alloc] initWithRootViewController:candiVC];
        
        ConversationListController *chatListVC = [[ConversationListController alloc] init];
        chatListVC.title = @"消息";
        chatListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];
        
        HWNavigationViewController *nav2 = [[HWNavigationViewController alloc] initWithRootViewController:chatListVC];
        
        
        HWJobsManagerController * jobsManager = [[HWJobsManagerController alloc] init];
        jobsManager.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"职位" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];
        HWNavigationViewController *naviCenter = [[HWNavigationViewController alloc] initWithRootViewController:jobsManager];
                                                  
        HWProcessListController *processList = [[HWProcessListController alloc] initWithNibName:nil bundle:nil];
        processList.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"进度" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];

        HWNavigationViewController *nav3 = [[HWNavigationViewController alloc] initWithRootViewController:processList];
        
        HWSettingController *setVC = [[HWSettingController alloc] init];
        setVC.title = @"我的";
        setVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"LYTabBarMyInfo"] selectedImage:[UIImage imageNamed:@"LYTabBarMyInfo_h"]];
        
        HWNavigationViewController *nav4 = [[HWNavigationViewController alloc] initWithRootViewController:setVC];
        
        tabController.viewControllers = @[navi1,nav3, naviCenter, nav2, nav4];
    }
    
    HWNavigationViewController *navi = [[HWNavigationViewController alloc] initWithRootViewController:tabController];
    navi.navigationBarHidden = YES;
    tabController.tabBar.tintColor = [UIColor colorWithRed:0.5 green:.9 blue:0.5 alpha:1.0];
    self.window.rootViewController = navi;
    
    [self loginUserIM];
}

@end
