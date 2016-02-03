//
//  OneViewController.m
//  TFSlidePage
//
//  Created by Fengtf on 16/1/27.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "OneViewController.h"
#import "DLTabedSlideView.h"
#import "TestViewController.h"

@interface OneViewController ()<DLTabedSlideViewDelegate>
@property (weak, nonatomic) DLTabedSlideView *tabedSlideView;

@end

@implementation OneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSlideView];
}

-(void)backViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initSlideView
{
    DLTabedSlideView *tabedSlideView = [[DLTabedSlideView alloc]init];
    [self.view addSubview:tabedSlideView];
    tabedSlideView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    self.tabedSlideView = tabedSlideView;
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.delegate = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor whiteColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
//    self.tabedSlideView.titleFont = [UIFont boldSystemFontOfSize:20];
    //    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    self.tabedSlideView.tabbarBottomSpacing = 0.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"日剧"];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"韩剧啊"];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"泰剧"];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    tabedSlideView.backgroundColor = [UIColor grayColor];
    self.tabedSlideView.selectedIndex = 0;
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0: {
            TestViewController *ctrl = [[TestViewController alloc] init];
            return ctrl;
        }
        case 1:  {
            TestViewController *ctrl = [[TestViewController alloc] init];
            return ctrl;
        }
        case 2:  {
            TestViewController *ctrl = [[TestViewController alloc] init];
            return ctrl;
        }
            
        default:
            return nil;
    }
}


@end
