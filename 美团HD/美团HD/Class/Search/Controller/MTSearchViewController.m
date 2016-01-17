//
//  MTSearchViewController.m
//  美团HD
//
//  Created by apple on 14/11/26.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "MTSearchViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MTConst.h"
#import "UIView+Extension.h"
#import "MJRefresh.h"

@interface MTSearchViewController () <UISearchBarDelegate>

@end

@implementation MTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

#pragma mark - 搜索框代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 进入下拉刷新状态, 发送请求给服务器
    [self.collectionView headerBeginRefreshing];
    
    // 退出键盘
    [searchBar resignFirstResponder];
}

#pragma mark - 实现父类提供的方法
- (void)setupParams:(NSMutableDictionary *)params
{
    params[@"city"] = @"北京";
    UISearchBar *bar = (UISearchBar *)self.navigationItem.titleView;
    params[@"keyword"] = bar.text;
}
@end