//
//  SPLeadProgressView.m
//  ShiPai
//
//  Created by zhiyuan on 16/9/9.
//  Copyright © 2016年 zhiyuan. All rights reserved.
//

#import "SPLeadProgressView.h"
#import "UIColor+RGB.h"
#import "Masonry.h"
#import "UIViewAdditions.h"

#define SPUnselectalbeColor [UIColor colorWithRGBHex:0x74868f] //0x888888]

@interface SPLeadProgressView()

@property(nonatomic, assign)CGFloat minTime;

@property(nonatomic, assign)CGFloat maxTime;

@property (nonatomic, strong)NSMutableArray *items;

@property (nonatomic, strong)UIView *minPosView;

@property (nonatomic, strong)UIView *flagView;

@property (nonatomic, strong)UIView *currentItem;

@property (nonatomic, assign)CGFloat currentTime;

@property (nonatomic, assign)CGFloat currentStartPos;

@property (nonatomic, assign)BOOL selected;
@end

@implementation SPLeadProgressView

- (instancetype)initWithMinTime:(CGFloat)min Max:(CGFloat)max
{
    self = [super init];
    self.maxTime = max;
    self.minTime = min;
    
    self.items = [NSMutableArray array];
    [self setBackgroundColor:[UIColor colorWithRed:.0 green:.0 blue:.0 alpha:.66]];
    
    UIView *minPos = [[UIView alloc] init];
    [minPos setBackgroundColor:[UIColor colorWithRGBHex:0xffffff alpha:0.66]];
    [self addSubview:minPos];
    self.minPosView = minPos;
    
    [minPos mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(1.);
        
        assert(max);
        make.centerX.mas_equalTo(self.mas_centerX).multipliedBy(min / max * 2);
    }];
    
    return self;
}

- (void)updateProgress:(CGFloat)progessTime
{
    self.currentTime = progessTime;
    
    [self updateCurrentItem];
    
    if (progessTime >= self.minTime) {
        UIColor *color = [UIColor colorWithRGBHex:0x00cfbe];
        [self updateAllItemWithColor:color];
    }
    else {
        UIColor *color = SPUnselectalbeColor;//[UIColor colorWithRGBHex:0x434e53];
        [self updateAllItemWithColor:color];
    }
}

- (void)pauseAtProgress:(CGFloat)progessTime
{
    [self updateProgress:progessTime];
    self.flagView.hidden = YES;
}

- (void)resumeProgress
{
    _selected = NO;
    
    if (self.currentTime >= self.minTime) {
        UIColor *color = [UIColor colorWithRGBHex:0x00cfbe];
        [self.currentItem setBackgroundColor:color];
    }
    else {
        UIColor *color = SPUnselectalbeColor;//[UIColor colorWithRGBHex:0x434e53];
        [self.currentItem setBackgroundColor:color];
    }
    
    if (self.currentItem) {
        self.flagView.hidden = NO;
        UIView *lastItem = [[UIView alloc] initWithFrame:self.currentItem.frame];
        [lastItem setBackgroundColor:self.currentItem.backgroundColor];
        
        [self insertSubview:lastItem belowSubview:self.minPosView];
        [self.items addObject:lastItem];
        
        self.currentStartPos = lastItem.origin.x + lastItem.size.width + .5;
        [self updateCurrentItem];
    }
    else {
        UIView *currentItem = [[UIView alloc] init];
        [currentItem setBackgroundColor:SPUnselectalbeColor];
        [self insertSubview:currentItem belowSubview:self.minPosView];

        self.currentItem = currentItem;
        
        [currentItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.mas_left).offset(self.currentStartPos);
            make.width.mas_equalTo(self.mas_width).multipliedBy(self.currentTime / self.maxTime).offset(-self.currentStartPos);
        }];
        
        UIView *flatItem = [[UIView alloc] init];
        [flatItem setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:flatItem];
        self.flagView = flatItem;
        
        [flatItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(currentItem.mas_right);
            make.width.mas_equalTo(4);
        }];
    }

}

- (void)selectLastPart
{
    self.selected = YES;
    [self.currentItem setBackgroundColor:[UIColor colorWithRGBHex:0xff2525 alpha:1.0]];
}

- (BOOL)isSelected
{
    return _selected;
}

- (void)removeLastPart
{
    if (self.items.count > 0) {
        [self.currentItem removeFromSuperview];
        UIView *lastItem = [self.items lastObject];
        self.currentItem = lastItem;
        [self.items removeObject:lastItem];
        
        self.currentStartPos = lastItem.origin.x + lastItem.size.width + 1.;

        [self.flagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.currentItem.mas_right);
            make.width.mas_equalTo(4);
        }];
    }
    else {
        self.currentStartPos = 0.;
        [self updateCurrentItem];
    }
    
    if (self.currentItem.frame.origin.x + self.currentItem.frame.size.width > self.minPosView.origin.x) {
        UIColor *color = [UIColor colorWithRGBHex:0x00cfbe];
        [self updateAllItemWithColor:color];
    }
    else {
        UIColor *color = SPUnselectalbeColor;//[UIColor colorWithRGBHex:0x434e53];
        [self updateAllItemWithColor:color];
    }
    
    _selected = NO;
}

- (void)updateAllItemWithColor:(UIColor *)color
{
    [self.currentItem setBackgroundColor:color];
    for (UIView *item in self.items) {
        [item setBackgroundColor:color];
    }
}

- (void)updateCurrentItem
{
    [self.currentItem mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).offset(self.currentStartPos);
        make.width.mas_equalTo(self.mas_width).multipliedBy(self.currentTime / self.maxTime).offset(-self.currentStartPos);
    }];
}

@end
