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
#import "DistrictViewController.h"

@interface HomeViewController ()
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

@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
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
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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
    popover.popoverContentSize = CGSizeMake(300, 500);
    [popover presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

//区域
-(void)districtClick
{
    DistrictViewController *cate = [[DistrictViewController alloc]init];
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:cate];
    popover.popoverContentSize = CGSizeMake(300, 500);
    [popover presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sortClick
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


#pragma mark - 监听城市改变
-(void)cityChage:(NSNotification *)notification
{
    NSString *cityName = notification.userInfo[TFSelectCityName];
//    NSLog(@"城市名字改变:%@",cityName);
    
    //1-更换听不区域item的文字
   TFHomeTopItem *topItem = (TFHomeTopItem *)self.districtItem.customView;
    topItem.title = [NSString stringWithFormat:@"%@ - 全部",cityName];
    topItem.subTitle = nil;
    
    //2-刷新表格数据
#warning TODO 
}


-(void)dealloc
{
    [TFNotificationCenter removeObserver:self];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
