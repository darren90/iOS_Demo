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
}

#pragma mark - 实现父类提供的方法
- (void)setupParams:(NSMutableDictionary *)params
{
    params[@"city"] = @"北京";
    UISearchBar *bar = (UISearchBar *)self.navigationItem.titleView;
    params[@"keyword"] = bar.text;
}


/**
 *  发送请求
 */
#pragma mark - 发送网络请求 - 服务器交互
//-(void)loadDeals
//{
//    DPAPI *api = [[DPAPI alloc]init];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"city"] = self.selectedCityName;
//    if (self.selectedCategoryName) {
//        params[@"category"] = self.selectedCategoryName;
//    }
//    // 每页的条数
//    params[@"limit"] = @6;
//    if (self.selectedSort) {
//        params[@"sort"] = @(self.selectedSort.value);
//    }
//    if (self.selectedRegionName) {
//        params[@"region"] = self.selectedRegionName;
//    }
//    // 页码
//    params[@"page"] = @(self.currentPage);
//    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
//    //    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
//}



@end







