//
//  TFDetailsViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFDetailsViewController.h"
#import "TFConst.h"
//#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
//#import "TFHomeTopItem.h"
//#import "TFHomeDropdown.h"
//#import "TFMetaTool.h"
//#import "TFCity.h"
// #import "TFSort.h"
//#import "TFCategory.h"
//#import "TFregion.h"
#import "DPAPI.h"
#import "MJExtension.h"
#import "TFDeal.h"
#import "MTDealCell.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
#import "UIView+AutoLayout.h"
#import "TFDetailViewController.h"


@interface TFDetailsViewController ()<DPRequestDelegate>
@property (nonatomic, weak) UIImageView *noDataView;


/** 总数 */
@property (nonatomic, assign) int  totalCount;
/** 所有的团购数据 */
@property (nonatomic, strong) NSMutableArray *deals;
/** 记录当前页码 */
@property (nonatomic, assign) int  currentPage;
/** 最后一个请求 */
@property (nonatomic, weak) DPRequest *lastRequest;
@end

@implementation TFDetailsViewController
static NSString * const reuseIdentifier = @"deal";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的大小
    layout.itemSize = CGSizeMake(305, 305);
    //    CGFloat inset = 15;
    //    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    return [self initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.view.backgroundColor = MTGlobalBg;
    self.collectionView.backgroundColor = MTGlobalBg;
    self.collectionView.alwaysBounceVertical = YES;
    
    // Register cell classes
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewDeals)];
    // 添加上拉刷新
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
}



//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
//    NSLog(@"size:%@",NSStringFromCGSize(size));
    // 根据屏幕宽度决定列数
    int cols = (size.width == 1024) ? 3 : 2;
    
    // 根据列数计算内边距
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = (size.width - cols * layout.itemSize.width) / (cols + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    // 设置每一行之间的间距
    layout.minimumLineSpacing = inset;
}
 

/**
 *  发送请求
 */
#pragma mark - 发送网络请求 - 服务器交互
-(void)loadDeals
{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"city"] = self.selectedCityName;
//    if (self.selectedCategoryName) {
//        params[@"category"] = self.selectedCategoryName;
//    }
//    if (self.selectedSort) {
//        params[@"sort"] = @(self.selectedSort.value);
//    }
//    if (self.selectedRegionName) {
//        params[@"region"] = self.selectedRegionName;
//    }
    // 调用子类实现的方法
    [self setupParams:params];
    
    // 每页的条数
    params[@"limit"] = @30;
    // 页码
    params[@"page"] = @(self.currentPage);
    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    //    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}


- (void)loadMoreDeals
{
    self.currentPage++;
    
    [self loadDeals];
}

- (void)loadNewDeals
{
    self.currentPage = 1;
    
    [self loadDeals];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    if (request != self.lastRequest) return;
    self.totalCount = [result[@"total_count"] intValue];
    
//    NSLog(@"请求成功:%@",result);
    // 1.取出团购的字典数组
    NSArray *newDeals = [TFDeal objectArrayWithKeyValuesArray:result[@"deals"]];
    if (self.currentPage == 1) { // 清除之前的旧数据
        [self.deals removeAllObjects];
    }
    [self.deals addObjectsFromArray:newDeals];
    
    // 2.刷新表格
    [self.collectionView reloadData];
    
    // 3.结束上拉加载
    [self.collectionView footerEndRefreshing];
      [self.collectionView headerEndRefreshing];
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
//    NSLog(@"请求失败:%@",error);
//    [MBProgressHUD showError:@"请稍后再试" toView:self.view];
    
    if (request != self.lastRequest) return;
    
    // 1.提醒失败
    [MBProgressHUD showError:@"网络繁忙,请稍后再试" toView:self.view];
    
    // 2.结束刷新
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    
    // 3.如果是上拉加载失败了
    if (self.currentPage > 1) {
        self.currentPage--;
    }
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    // 计算一遍内边距
    [self viewWillTransitionToSize:CGSizeMake(collectionView.width, 0) withTransitionCoordinator:nil];
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 控制尾部刷新控件的显示和隐藏
    self.collectionView.footerHidden = (self.totalCount == self.deals.count);
    
    // 控制"没有数据"的提醒
    self.noDataView.hidden = (self.deals.count != 0);
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.deal = self.deals[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFDeal *deal = self.deals[indexPath.row];
    
}

- (UIImageView *)noDataView
{
    if (!_noDataView) {
        // 添加一个"没有数据"的提醒
        UIImageView *noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        [self.view addSubview:noDataView];
        [noDataView autoCenterInSuperview];
        self.noDataView = noDataView;
    }
    return _noDataView;
}


- (NSMutableArray *)deals
{
    if (!_deals) {
        self.deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}

@end
