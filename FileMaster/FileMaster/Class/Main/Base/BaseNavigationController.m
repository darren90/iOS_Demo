//
//  BaseNavigationController.m
//  FileMaster
//
//  Created by Tengfei on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//系统第一次使用这个类的时候会调用
+(void)initialize
{
    //导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NarBar"] forBarMetrics:UIBarMetricsDefault];
    
    //去除navbar下面的线条
    //    [navBar setShadowImage:[UIImage new]];
    
    //返回箭头的按钮的颜色
    navBar.tintColor = [UIColor whiteColor];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:dict];
    
    //UIBarButtonItem主题设置
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *Ddict = [NSMutableDictionary dictionary];
    Ddict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    Ddict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:Ddict forState:UIControlStateNormal];
    
    NSMutableDictionary *Hdict = [NSMutableDictionary dictionary];
    Hdict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:Hdict forState:UIControlStateHighlighted];
    
    NSMutableDictionary *Disdict = [NSMutableDictionary dictionary];
    Disdict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:Disdict forState:UIControlStateDisabled];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    // fix 'nested pop animation can result in corrupted navigation bar'
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    //    NSLog(@"subVCs:%lu",(unsigned long)self.viewControllers.count);
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//        self.tabBarController.tabBar.backgroundColor = [UIColor clearColor];
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}




- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}


@end
