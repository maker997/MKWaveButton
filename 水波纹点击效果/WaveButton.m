//
//  WaveButton.m
//  水波纹点击效果
//
//  Created by 刘甲奇 on 2016/12/23.
//  Copyright © 2016年 刘甲奇. All rights reserved.
//

#import "WaveButton.h"

@interface WaveButton ()
/* 按钮 */
@property(nonatomic,strong) UIView *RippleView;

@end

@implementation WaveButton

- (instancetype)initWithFrame:(CGRect)frame
{
  
    self = [super initWithFrame:frame];
    if (self) {
        
        _RippleView = [[UIView alloc] init];
        _RippleView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];

        _RippleView.alpha=0;
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    CGFloat max = frame.size.width > frame.size.height ? frame.size.width : frame.size.height;
    _RippleView.frame = CGRectMake(0, 0, 2*max, 2*max);
    _RippleView.layer.cornerRadius = max;
    _RippleView.layer.masksToBounds=true;
    [super setFrame:frame];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    CGPoint location = [touch locationInView:self];
    [self addSubview:_RippleView];
    _RippleView.center = location;
    _RippleView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    [UIView animateWithDuration:0.1 animations:^{
        _RippleView.alpha = 1;
        self.alpha = 0.9;
    }];
    
    [UIView animateWithDuration:0.8 animations:^{
        _RippleView.transform = CGAffineTransformMakeScale(1, 1);
        _RippleView.alpha = 0;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [_RippleView removeFromSuperview];
    }];
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}



@end






