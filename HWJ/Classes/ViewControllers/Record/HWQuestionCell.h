//
//  HWQuestionCell.h
//  HWJ
//
//  Created by zhiyuan on 16/10/13.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWQuestionCell : UITableViewCell

@property (nonatomic, assign)BOOL isLastItem;

- (void)loadQuestion:(NSString *)question atIndex:(NSInteger)index;

@end
