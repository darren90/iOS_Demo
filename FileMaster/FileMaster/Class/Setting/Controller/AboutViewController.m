//
//  AboutViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
- (IBAction)openWeibo:(UIButton *)sender;

- (IBAction)openGithub:(UIButton *)sender;

@end

@implementation AboutViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Page_关于"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Page_关于"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"当前版本%@",appVersion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openWeibo:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/fengtengfei90"]];
}

- (IBAction)openGithub:(UIButton *)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/darren90"]];
}
@end
