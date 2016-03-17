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
    //    CAKeyframeAnimation //按照轨迹走
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //    group.repeatCount = MAXFLOAT;
    group.duration = 3;
    
    CABasicAnimation *ratation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    //    ratation.keyPath = @"transform";
    //    CATransform3D t3d = CATransform3DMakeRotation(M_PI*MAXFLOAT, 1, 0, 0);
    //    ratation.toValue = [NSValue valueWithCATransform3D:t3d];
    //    ratation.repeatCount = MAXFLOAT;
    //    ratation.duration = MAXFLOAT;
    ratation.toValue = [NSNumber numberWithFloat: M_PI * 2.0*2000000 ];//倍数放大，一直可以转
    ratation.duration = 2000000;
    ratation.cumulative = YES;
    
    CABasicAnimation *position = [CABasicAnimation animation];
    position.keyPath = @"position";
    position.fromValue = [NSValue valueWithCGPoint:self.imageView.layer.position]; // 起始帧
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(self.imageView.layer.position.x, self.imageView.layer.position.y - 300)]; // 终了帧
    
    group.animations = @[ratation,position];
    
    [self.imageView.layer addAnimation:group forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
