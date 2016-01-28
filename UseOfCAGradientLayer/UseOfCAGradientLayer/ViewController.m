//
//  ViewController.m
//  UseOfCAGradientLayer
//
//  Created by Tengfei on 16/1/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setGradientLayer];
}

-(void)setGradientLayer
{
    // 创建渐变色图层
    self.gradientLayer             = [CAGradientLayer layer];
    self.gradientLayer.frame       = CGRectMake(100, 100, 200, 200);
//    self.gradientLayer. = self.view;
    self.gradientLayer.borderWidth = 1;
    
    self.gradientLayer.colors = @[
                                  (id)[UIColor grayColor].CGColor,
                                  (id)[UIColor blueColor].CGColor,
                                  (id)[UIColor whiteColor].CGColor
                                  ];
    // 设置渐变方向(0~1)
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    // 设置渐变色的起始位置和终止位置(颜色的分割点)
    self.gradientLayer.locations = @[@(0.5f),@(0.15f), @(0.70)];
    self.gradientLayer.borderWidth  = 0.0;
    
    // 添加图层
    [self.view.layer addSublayer:self.gradientLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
