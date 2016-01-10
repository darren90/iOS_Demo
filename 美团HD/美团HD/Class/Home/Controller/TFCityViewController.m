//
//  TFCityViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/10.
//  Copyright © 2016年 tengfei. All rights reserved.
//


#import "TFCityViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@interface TFCityViewController ()

@end

@implementation TFCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" highImage:@"btn_navigation_close_hl"];
    
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
