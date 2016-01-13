//
//  HomeViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "HomeViewController.h"
#import "TFConst.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "TFHomeTopItem.h"
#import "TFHomeDropdown.h"
#import "CategoryController.h"
#import "TFReginViewController.h"
#import "TFMetaTool.h"
#import "TFCity.h"
#import "TFSortViewController.h"
#import "TFSort.h"
#import "TFCategory.h"
#import "TFregion.h"
#import "DPAPI.h"
#import "MJExtension.h"
#import "TFDeal.h"
#import "MTDealCell.h"

@interface HomeViewController ()<DPRequestDelegate>
/**
 *  分类item
 */
@property (nonatomic,weak)UIBarButtonItem * categoryItem;
/**
 *  区域item
 */
@property (nonatomic,weak)UIBarButtonItem * districtItem;
/**
 *  排序item
 */
@property (nonatomic,weak)UIBarButtonItem * sortItem;

/** 当前选中的城市名字 */
@property (nonatomic, copy) NSString *selectedCityName;
/** 当前选中的分类的名字 */
@property (nonatomic, copy) NSString *selectedCategoryName;
/** 当前选中的排序的名字 */
@property (nonatomic, strong) TFSort *selectedSort;
/** 当前选中的区域的名字 */
@property (nonatomic, copy) NSString *selectedRegionName;
/**
 *  分类popover
 */
@property (nonatomic,strong)UIPopoverController * categoryPopover;
/**
 *  区域popover
 */
@property (nonatomic,strong)UIPopoverController * regionPopover;
/**
 *  排序popover
 */
@property (nonatomic,strong)UIPopoverController * sortPopover;

/** 所有的团购数据 */
@property (nonatomic, strong) NSMutableArray *deals;
@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"deal";


- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的大小
    layout.itemSize = CGSizeMake(305, 305);
    return [self initWithCollectionViewLayout:layout];
}


/**
    //tableview
 *  self.view == self.tableview
    //collectionView
    self.view == self.collectionView.superview
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.view.backgroundColor = MTGlobalBg;
    self.collectionView.backgroundColor = MTGlobalBg;
    
    //监听城市选择的通知
    [TFNotificationCenter addObserver:self selector:@selector(cityChage:) name:TFCityDidSelectNotification object:nil];
    
    //监听排序改变
    [TFNotificationCenter addObserver:self selector:@selector(sortChage:) name:TFSortDidSelectNotification object:nil];

    //监听排序改变
    [TFNotificationCenter addObserver:self selector:@selector(categoryChage:) name:TFCategoryDidSelectNotification object:nil];
    
    //监听区域改变
    [TFNotificationCenter addObserver:self selector:@selector(regionChage:) name:TFReginDidSelectNotification object:nil];

    
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    
    // Do any additional setup after loading the view.
    
    //设置导航栏内容
    [self setupLeftNav];
    [self setupRightNav];
}

-(void)setupLeftNav
{
    //1.logol
    UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logo.enabled = NO;
    
    //2.
    TFHomeTopItem *categoryItem = [TFHomeTopItem item];
    [categoryItem addTaget:self action:@selector(categoryClick)];
    UIBarButtonItem *category = [[UIBarButtonItem alloc]initWithCustomView:categoryItem];
    self.categoryItem = category;

    //3.
    TFHomeTopItem *districItem = [TFHomeTopItem item];
    [districItem addTaget:self action:@selector(districtClick)];
    UIBarButtonItem *distric = [[UIBarButtonItem alloc]initWithCustomView:districItem];
    self.districtItem = distric;
    
    //4.
    TFHomeTopItem *sortItem = [TFHomeTopItem item];
    sortItem.title = @"排序";
    [sortItem setIcon:@"icon_sort" highIcon:@"icon_sort_highlighted"];
    [sortItem addTaget:self action:@selector(sortClick)];
    UIBarButtonItem *sort = [[UIBarButtonItem alloc]initWithCustomView:sortItem];
    self.sortItem = sort;
    
    self.navigationItem.leftBarButtonItems = @[logo,category,distric,sort];
}

-(void)setupRightNav
{
    UIBarButtonItem *map = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_map" highImage:@"icon_map_highlighted"];
    map.customView.width = 60;
    
    UIBarButtonItem *search = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_search" highImage:@"icon_search_highlighted"];
    search.customView.width = 60;
    self.navigationItem.rightBarButtonItems = @[map, search];
}
#pragma mark - 顶部item的点击方法
-(void)categoryClick
{
//    NSLog(@"categoryClick");
    //
    CategoryController *cate = [[CategoryController alloc]init];
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:cate];
    popover.popoverContentSize = CGSizeMake(360, 500);
    self.categoryPopover = popover;
    [popover presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

//区域
-(void)districtClick
{
    TFReginViewController *cate = [[TFReginViewController alloc]init];
    //获取当前选中城市的区域
    NSLog(@"--:selectedCityName:%@",self.selectedCityName);
    if (self.selectedCityName) {
//MTCity *city = [[[MTMetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@", self.selectedCityName]] firstObject];
        NSArray *array = [[TFMetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",self.selectedCityName]] ;
        TFCity *city = [array firstObject];
        cate.regions = city.regions;
    }
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:cate];
    popover.popoverContentSize = CGSizeMake(300, 500);
     self.regionPopover = popover;
    [popover presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
//排序
-(void)sortClick
{
    TFSortViewController *sort = [[TFSortViewController alloc]init];
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:sort];
//    popover.popoverContentSize = CGSizeMake(300, 500);
     self.sortPopover = popover;
    [popover presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.deal = self.deals[indexPath.row];
    
    return cell;
}


#pragma mark - 监听城市改变
-(void)cityChage:(NSNotification *)notification
{
    self.selectedCityName = notification.userInfo[TFSelectCityName];
//    NSLog(@"城市名字改变:%@",cityName);
    
    //1-更换听不区域item的文字
   TFHomeTopItem *topItem = (TFHomeTopItem *)self.districtItem.customView;
//    self.selectedCityName = cityName;
    topItem.title = [NSString stringWithFormat:@"%@ - 全部",self.selectedCityName];
    topItem.subTitle = nil;
    
    [self.regionPopover dismissPopoverAnimated:YES];
    
    //2-刷新表格数据
#warning TODO 
    [self loadNewDeals];
}

#pragma mark - 监听排序改变
-(void)sortChage:(NSNotification *)notification
{
    TFSort *sort = notification.userInfo[TFSelectSortName];
    self.selectedSort = sort;
    //1-更换听不区域item的文字
    TFHomeTopItem *topItem = (TFHomeTopItem *)self.sortItem.customView;
    topItem.subTitle = sort.label;
    
    //2-刷新表格数据
#warning TODO
     [self loadNewDeals];
}

#pragma mark - 分类排序改变
-(void)categoryChage:(NSNotification *)notification
{
    TFCategory *category = notification.userInfo[TFSelectCategoryName];
    NSString *subCategory = notification.userInfo[TFSelectSubCategoryName];
    
    if (subCategory == nil) {
        self.selectedCategoryName = category.name;
    }else{
        self.selectedCategoryName = [subCategory isEqualToString:@"全部"] ? category.name : subCategory;
    }
    
    if ([self.selectedCategoryName isEqualToString:@"全部分类"]) {
        self.selectedCategoryName = nil;
    }
    
    //1-更换分类item的文字
    TFHomeTopItem *topItem = (TFHomeTopItem *)self.categoryItem.customView;
    [topItem setIcon:category.icon highIcon:category.highlighted_icon];
    topItem.title = category.name;
    topItem.subTitle = subCategory ? subCategory : @"全部";
    //关闭popover
    [self.categoryPopover dismissPopoverAnimated:YES];
    
    //2-刷新表格数据
#warning TODO
    [self loadNewDeals];
}

#pragma mark - 区域改变
-(void)regionChage:(NSNotification *)notification
{
    TFregion  *region = notification.userInfo[TFSelectReginName];
    NSString *subRegion = notification.userInfo[TFSelectSubReginName];
    
    if (subRegion == nil || [subRegion isEqualToString:@"全部"]) {
        self.selectedRegionName = region.name;
    }else{
        self.selectedRegionName = subRegion;
    }
    
    if ([self.selectedRegionName isEqualToString:@"全部分类"]) {
        self.selectedRegionName = nil;
    }
    
    //1-更换分类item的文字
    TFHomeTopItem *topItem = (TFHomeTopItem *)self.districtItem.customView;
//    [topItem setIcon:category.icon highIcon:category.highlighted_icon];
    topItem.title = [NSString stringWithFormat:@"%@ - %@",self.selectedCityName,region.name];
    topItem.subTitle = subRegion ? subRegion : @"全部";
    //关闭popover
    [self.regionPopover dismissPopoverAnimated:YES];
    
    //2-刷新表格数据
#warning TODO
     [self loadNewDeals];
}

/**
 *  发送请求
 */
#pragma mark - 发送网络请求 - 服务器交互
-(void)loadNewDeals
{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.selectedCityName;
    if (self.selectedCategoryName) {
        params[@"category"] = self.selectedCategoryName;
    }
    if (self.selectedSort) {
        params[@"sort"] = @(self.selectedSort.value);
    }
    if (self.selectedRegionName) {
        params[@"region"] = self.selectedRegionName;
    }
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}


-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"请求成功:%@",result);
    MTLog(@"%@", result);
    // 1.取出团购的字典数组
    NSArray *newDeals = [TFDeal objectArrayWithKeyValuesArray:result[@"deals"]];
    [self.deals removeAllObjects];
    [self.deals addObjectsFromArray:newDeals];
    
    // 2.刷新表格
    [self.collectionView reloadData];

}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"请求失败:%@",error);
}

- (NSMutableArray *)deals
{
    if (!_deals) {
        self.deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}
-(void)dealloc
{
    [TFNotificationCenter removeObserver:self];
}

#pragma mark <UICollectionViewDelegate>



@end
