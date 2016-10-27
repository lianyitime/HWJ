//
//  SCWatermarkOverlayView.m
//  SCRecorderExamples
//
//  Created by Simon CORSIN on 16/06/15.
//
//

#import "SCWatermarkOverlayView.h"
#import "Masonry.h"

@interface SCWatermarkOverlayView() {
    
    UIImageView *_watermarkImgView;//SPLoginPaipaijiang
}


@end

@implementation SCWatermarkOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _watermarkImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watermark_short_film_paipaijiang"]];
        [self addSubview:_watermarkImgView];
        CGFloat rate = MIN(frame.size.width /[UIScreen mainScreen].bounds.size.width, frame.size.height / [UIScreen mainScreen].bounds.size.height);
        [_watermarkImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            //播放时水印在播放中和退出对齐
            make.right.mas_equalTo(-14 * rate);
            make.top.mas_equalTo(69. * rate);
            make.width.mas_equalTo(_watermarkImgView.image.size.width * rate);
            make.height.mas_equalTo(_watermarkImgView.image.size.height * rate);
        }];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    [_watermarkImgView setImage:image];
}

@end
