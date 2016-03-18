//
//  ViewController.m
//  iOS核心动画集
//
//  Created by Fengtf on 16/3/18.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = MAXFLOAT;
    group.duration = 3;
    
    CABasicAnimation *ratation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    ratation.toValue = [NSNumber numberWithFloat: M_PI * 10.0*20000000 ];//倍数放大，一直可以转
    ratation.duration = 20000000;
    ratation.cumulative = YES;
    
    CABasicAnimation *position = [CABasicAnimation animation];
    position.keyPath = @"position";
    position.fromValue = [NSValue valueWithCGPoint:self.imageView.layer.position]; // 起始帧
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(self.imageView.layer.position.x, self.imageView.layer.position.y - 300)]; // 终了帧
    
    group.animations = @[ratation,position];
//    group.
    
    [self.imageView.layer addAnimation:group forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
