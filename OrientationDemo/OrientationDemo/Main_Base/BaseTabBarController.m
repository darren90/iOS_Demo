//
//  BaseTabBarController.m
//  OrientationDemo
//
//  Created by Fengtf on 16/1/8.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  Description
 *
 *  @return return value description
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
//    NSLog(@"nav___top:%@",self.viewControllers);

    return YES;
}

 
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//
//    //    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    return [self.viewControllers.lastObject supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
////    NSLog(@"UIInterfaceOrientation--:%@--:%@",self.viewControllers,self.viewControllers.lastObject);
//    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
//}



@end
