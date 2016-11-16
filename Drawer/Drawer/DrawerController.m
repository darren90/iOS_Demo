//
//  DrawerController.m
//  Drawer
//
//  Created by Tengfei on 16/11/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "DrawerController.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define targetX 275
#define maxY 100
@interface DrawerController ()

@end

@implementation DrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _leftView = [self initlizeView];
    _rightView = [self initlizeView];
    _mainView = [self initlizeView];
 

    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self.mainView addGestureRecognizer:pan];
    
    
    //给控制器的View添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint offsetP = [pan translationInView:self.mainView];
    self.mainView.frame = [self getFrameWithOffsetX:offsetP.x];
    
    if (CGRectGetMinX(self.mainView.frame) > 0) {
        self.rightView.hidden = YES;
    }else if (CGRectGetMinX(self.mainView.frame) < 0){
        self.rightView.hidden = NO;
    }
    
    CGFloat endX = 0;
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (CGRectGetMinX(self.mainView.frame) > screenW /2) {
            endX = targetX;
        }else if (CGRectGetMaxX(self.mainView.frame) < screenW /2){
            endX = -targetX;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            self.mainView.frame = [self getFrameWithOffsetX:(endX - self.mainView.frame.origin.x)];
        }];
    }
    
    //复位
    [pan setTranslation:CGPointZero inView:self.mainView];
}

 //让MainV复位
- (void)tap
{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}

//计算缩小后的主界面的view
-(CGRect)getFrameWithOffsetX:(CGFloat)offsetX
{
    CGRect frame = self.mainView.frame;
    frame.origin.x += offsetX;
    CGFloat y = fabs(frame.origin.x * maxY / screenW);
    frame.origin.y = y;
    frame.size.height = [UIScreen mainScreen].bounds.size.height - 2*y;
    return frame;
}



-(UIView *)initlizeView
{
    UIView *targetView = [[UIView alloc]initWithFrame:self.view.bounds];
//    view = targetView;
    [self.view addSubview:targetView];
    return targetView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
