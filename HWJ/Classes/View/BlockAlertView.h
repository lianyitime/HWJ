//
//  BlockAlertView.h
//  FXBEST
//
//  Created by 杜宇 on 15/3/14.
//  Copyright (c) 2015年 51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)();
typedef void (^ClickBlock)(int index);

@interface BlockAlertView : UIAlertView
@property (nonatomic, copy) block block;
@property (nonatomic, copy) ClickBlock clickBlock;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickBlock:(ClickBlock)clickBlock cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickBlock:(ClickBlock)clickBlock cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;
@end
