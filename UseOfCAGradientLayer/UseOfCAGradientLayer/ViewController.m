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
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *secView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setGradientLayer1];
    [self setGradientLayer2];
}
-(void)setGradientLayer2
{
    // 创建渐变色图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame       = self.secView.bounds;
    
    gradientLayer.colors = @[
                                (id)[UIColor cyanColor].CGColor,
                                  (id)[UIColor blueColor].CGColor,
                                  (id)[UIColor redColor].CGColor
                                  ];
    // 设置渐变方向(0~1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    // 设置渐变色的起始位置和终止位置(颜色的分割点)
    gradientLayer.locations = @[@(0.05f),@(0.70f),@(0.25f)];
    gradientLayer.borderWidth  = 0.0;
    
    // 添加图层
    [self.secView.layer addSublayer:gradientLayer];
}


-(void)setGradientLayer1
{
    // 创建渐变色图层
    CAGradientLayer *gradientLayer= [CAGradientLayer layer];
    gradientLayer.frame       = self.imgView.bounds;//CGRectMake(100, 100, 200, 200);
    
    gradientLayer.colors = @[
                                  (id)[UIColor clearColor].CGColor,
                                  (id)[UIColor whiteColor].CGColor
                                  ];
    // 设置渐变方向(0~1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    // 设置渐变色的起始位置和终止位置(颜色的分割点)
    gradientLayer.locations = @[@(0.15f),@(0.95f)];
    gradientLayer.borderWidth  = 0.0;
    
    // 添加图层
    [self.imgView.layer addSublayer:gradientLayer];
}



@end
