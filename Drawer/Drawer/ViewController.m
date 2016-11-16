//
//  ViewController.m
//  Drawer
//
//  Created by Tengfei on 16/11/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "ViewController.h"

#import "DrawerController.h"

#import "LeftDemoViewController.h"
#import "CenterDemoViewController.h"
#import "RightDemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //当一个控制器的View添加到另一个控制器的View上的时候,那此时View所在的控制器也应该成为上一个控制器的子控制器.
    CenterDemoViewController *vc1 = [[CenterDemoViewController alloc] init];
    vc1.view.frame = self.mainView.bounds;
    [self.mainView addSubview:vc1.view];
    [self addChildViewController:vc1];
    
    
    LeftDemoViewController *vc2 = [[LeftDemoViewController alloc] init];
    vc2.view.backgroundColor = [UIColor redColor];
    vc2.view.frame = self.mainView.bounds;
    [self.leftView addSubview:vc2.view];
    [self addChildViewController:vc2];
    
    RightDemoViewController *vc3 = [[RightDemoViewController alloc] init];
    vc3.view.backgroundColor = [UIColor blackColor];
    vc3.view.frame = self.mainView.bounds;
    [self.rightView addSubview:vc3.view];
    [self addChildViewController:vc3];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
