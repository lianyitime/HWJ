//
//  BlockAlertView.m
//  FXBEST
//
//  Created by 杜宇 on 15/3/14.
//  Copyright (c) 2015年 51fanxing. All rights reserved.
//

#import "BlockAlertView.h"

@implementation BlockAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickBlock:(ClickBlock)clickBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles
{
    BlockAlertView *alertView = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    self.clickBlock = clickBlock;
    return alertView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.clickBlock((int)buttonIndex);
}


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickBlock:(ClickBlock)clickBlock cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    BlockAlertView *alertView = [self initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    for (NSString *title in otherButtonTitles) {
        
        [alertView addButtonWithTitle:title];
    }
    
    self.clickBlock = clickBlock;
    return alertView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
