//
//  ViewController.m
//  水波纹点击效果
//
//  Created by 刘甲奇 on 2016/12/23.
//  Copyright © 2016年 刘甲奇. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Wave.h"

@interface ViewController ()

/* 按钮 */
@property(nonatomic,strong) UIView *RippleView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 100, 250, 60);
    [self.view addSubview:button];
    button.isShowWave = YES;
    
    
    [button setTitle:@"点我" forState:0];
    [button setTitleColor:[UIColor blueColor] forState:0];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)btnClick:(UIButton *)sender
{
    
}



@end











