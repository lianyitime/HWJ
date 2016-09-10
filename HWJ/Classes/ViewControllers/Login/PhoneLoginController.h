//
//  PhoneLoginController.h
//  ShiPai
//
//  Created by duyu-mac on 16/5/8.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhoneLoginController;
@protocol PhoneLoginControllerDelegate <NSObject>

- (void)phoneLoginController:(PhoneLoginController *)phoneLoginController didLoginWithUserInfo:(NSDictionary *)userInfo;

@end

@interface PhoneLoginController : UIViewController
@property (nonatomic, weak) id<PhoneLoginControllerDelegate> delegate;
@end
