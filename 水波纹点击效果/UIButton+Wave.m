//
//  UIButton+Wave.m
//  水波纹点击效果
//
//  Created by 刘甲奇 on 2016/12/23.
//  Copyright © 2016年 刘甲奇. All rights reserved.
//

#import "UIButton+Wave.h"
#import <objc/runtime.h>

@interface UIButton ()
/* 波纹视图 */
@property(nonatomic,strong) UIView *waveView;

@end

@implementation UIButton (Wave)

#pragma mark =================== setter,getter ===================
static const char *waveViewId = "waveView";
static const char *showWave = "showWave";
- (void)setIsShowWave:(BOOL)isShowWave
{
    self.waveView.hidden = isShowWave ? NO : YES;
    objc_setAssociatedObject(self, showWave, @(isShowWave), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isShowWave
{
    return objc_getAssociatedObject(self, showWave);
}
- (UIView *)waveView
{
    return objc_getAssociatedObject(self, waveViewId);
}
- (void)setWaveView:(UIView *)waveView
{

    objc_setAssociatedObject(self, waveViewId, waveView, OBJC_ASSOCIATION_RETAIN);
    
}
#pragma mark =================== 运行时替换方法 ===================
+ (void)load
{
    SwizzleMethod(self, @selector(initWithFrame:), @selector(mk_initWithFrame:));
    SwizzleMethod(self, @selector(setFrame:), @selector(mk_setFrame:));
    SwizzleMethod(self, @selector(beginTrackingWithTouch:withEvent:), @selector(mk_beginTrackingWithTouch:withEvent:));
}

void SwizzleMethod(Class c,SEL orignSEL, SEL replaceSEL)
{
    
    Method orignMethod = class_getInstanceMethod(c, orignSEL);
    Method replaceMethod = class_getInstanceMethod(c, replaceSEL);
    
    if (class_addMethod(c, orignSEL, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod)))
    {
        class_replaceMethod(c, replaceSEL, method_getImplementation(orignMethod), method_getTypeEncoding(orignMethod));
    }else
    {
        method_exchangeImplementations(orignMethod, replaceMethod);
    }
    
}

#pragma mark =================== 自己的方法 ===================
- (instancetype)mk_initWithFrame:(CGRect)frame
{
    self.waveView = [[UIView alloc] init];
    self.waveView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.waveView.alpha=0;
    self.clipsToBounds = YES;
    
    return [self mk_initWithFrame:frame];
}
- (void)mk_setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat max = frame.size.width > frame.size.height ? frame.size.width : frame.size.height;
    self.waveView.frame = CGRectMake(0, 0, 2*max, 2*max);
    self.waveView.layer.cornerRadius = max;
    self.waveView.layer.masksToBounds=true;
    self.clipsToBounds = YES;
    
}

- (BOOL)mk_beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    CGPoint location = [touch locationInView:self];
    [self addSubview: self.waveView];
    self.waveView.center = location;
    self.waveView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    [UIView animateWithDuration:0.1 animations:^{
        self.waveView.alpha = 1;
        self.alpha = 0.9;
    }];
    
    [UIView animateWithDuration:0.8 animations:^{
        self.waveView.transform = CGAffineTransformMakeScale(1, 1);
        self.waveView.alpha = 0;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self.waveView removeFromSuperview];
    }];
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}
@end
























