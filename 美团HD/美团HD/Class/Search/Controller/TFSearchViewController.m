//
//  TFSearchViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFSearchViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "TFConst.h"
#import "UIView+Extension.h"
#import "MJRefresh.h"

@interface TFSearchViewController ()<UISearchBarDelegate>

@end

@implementation TFSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 左边的返回
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_back" highImage:@"icon_back_highlighted"];
    
    //    UIView *titleView = [[UIView alloc] init];
    //    titleView.width = 300;
    //    titleView.height = 35;
    //    titleView.backgroundColor = [UIColor redColor];
    //    self.navigationItem.titleView = titleView;
    
    // 中间的搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"请输入关键词";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    //    searchBar.frame = titleView.bounds;
    //    [titleView addSubview:searchBar];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{    
    [self.collectionView headerBeginRefreshing];
    //退出键盘，进行搜索
    [searchBar resignFirstResponder];
}

#pragma mark - 实现父类提供的方法
- (void)setupParams:(NSMutableDictionary *)params
{
    params[@"city"] = self.cityName;
    UISearchBar *bar = (UISearchBar *)self.navigationItem.titleView;
    params[@"keyword"] = bar.text;
}






@end







