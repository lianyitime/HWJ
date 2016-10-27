//
//  SPMiniVideoRecorderController+question.m
//  HWJ
//
//  Created by zhiyuan on 16/10/13.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "SPMiniVideoRecorderController+question.h"
#import "HWQuestionCell.h"
#import "Masonry.h"

@implementation SPMiniVideoRecorderController (question)

static NSString *cellId = @"cell";

- (void)startLoadQuestion:(QuestionBlock)handler
{
    if (self.questionTable == nil) {
        CGRect frame = self.view.bounds;
        frame.origin.y += 30;
        frame.size.height -= 30;
        UITableView *table = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        [table setBackgroundColor:[UIColor clearColor]];
        [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [table registerClass:[HWQuestionCell class] forCellReuseIdentifier:cellId];
        [self.view insertSubview:table belowSubview:self.contentView];
        self.questionTable = table;
        
//        [table mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.view.mas_left);
//            make.right.mas_equalTo(self.view.mas_right).offset(-100);
//            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100);
//            make.height.mas_lessThanOrEqualTo(self.view.mas_height);
//        }];
        
    }
    if(!self.isStartAnswer) {
        [self loadQuestionsData:handler];
        self.isStartAnswer = YES;
    }
    else {
        [self loadNextQuestion:handler];
    }
}

- (void)loadNextQuestion:(QuestionBlock)handler
{
    if (self.currentQuestions.count < self.questionsTotal) {
        NSString *question = nil;
        switch (self.currentQuestions.count) {
            case 0:
                question = @"先做个简单自我介绍，并重点说下最近一份工作的内容与职责";
                break;
            case 1:
                question = @"说说你对行业、技术发展趋势的看法？";
                break;
            case 2:
                question = @"谈谈你过去做过的成功案例？";
                break;
            case 3:
                question = @"你做过的哪件事最令自己感到骄傲？对这项工作，你有哪些可预见的困难？";
                break;
            case 4:
                question = @"最近一次工作离职的原因是什么";
                break;
            default:
                question = @"你能为我们公司带来什么呢？";
                break;
        }
        if (self.currentQuestions == nil) {
            self.currentQuestions = [NSMutableArray arrayWithCapacity:5];
        }
        [self.currentQuestions addObject:question];
        [self.questionTable reloadData];
        
        handler(nil);
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        });
        
    }

}

- (void)finishedAnswer
{
    
}

- (void)loadQuestionsData:(QuestionBlock)handler
{
    self.questionsTotal = 5;
    NSString *question = @"先做个简单自我介绍，并重点说下最近一份工作的内容与职责";
    if (self.currentQuestions == nil) {
        self.currentQuestions = [NSMutableArray arrayWithCapacity:5];
    }
    [self.currentQuestions addObject:question];
    [self.questionTable reloadData];
    handler(nil);
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    });
}

#pragma mark - UITableViewDelegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentQuestions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSInteger index = [indexPath row];
    NSString *title = [self.currentQuestions objectAtIndex:index];
    [cell setIsLastItem:(index == self.currentQuestions.count - 1)];
    [cell loadQuestion:title atIndex:index];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

@end
