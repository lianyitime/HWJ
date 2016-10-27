//
//  SPMiniVideoRecorderController+question.h
//  HWJ
//
//  Created by zhiyuan on 16/10/13.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "SPMiniVideoRecorderController.h"

typedef void(^QuestionBlock)(NSError *error);

@interface SPMiniVideoRecorderController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *questionTable;

@property(nonatomic, strong)NSMutableArray *currentQuestions;

@property (nonatomic, assign)NSInteger questionsTotal;

@property (nonatomic, assign)BOOL isStartAnswer;

- (void)startLoadQuestion:(QuestionBlock)handler;

- (void)loadNextQuestion:(QuestionBlock)handler;

- (void)finishedAnswer;

@end
