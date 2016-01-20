//
//  TFCollectViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFCollectViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "TFConst.h"
#import "UIView+Extension.h"
#import "MJRefresh.h"
#import "MTDealTool.h"
#import "MTDealCell.h"
#import "UIView+AutoLayout.h"
#import "TFDetailViewController.h"

NSString *const MTDone = @"完成";
NSString *const MTEdit = @"编辑";
#define MTString(str) [NSString stringWithFormat:@"  %@  ", str]

@interface TFCollectViewController ()

@property (nonatomic,strong)NSMutableArray  * deals;

@property (nonatomic, weak) UIImageView *noDataView;
 @property (nonatomic, assign) int currentPage;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *selectAllItem;
@property (nonatomic, strong) UIBarButtonItem *unselectAllItem;
@property (nonatomic, strong) UIBarButtonItem *removeItem;
@end

@implementation TFCollectViewController

static NSString * const reuseIdentifier = @"deal";

- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        self.backItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_back" highImage:@"icon_back_highlighted"];
    }
    return _backItem;
}

- (UIBarButtonItem *)selectAllItem
{
    if (!_selectAllItem) {
        self.selectAllItem = [[UIBarButtonItem alloc] initWithTitle:MTString(@"全选") style:UIBarButtonItemStyleDone target:self action:@selector(selectAll)];
    }
    return _selectAllItem;
}

- (UIBarButtonItem *)unselectAllItem
{
    if (!_unselectAllItem) {
        self.unselectAllItem = [[UIBarButtonItem alloc] initWithTitle:MTString(@"全不选") style:UIBarButtonItemStyleDone target:self action:@selector(unselectAll)];
    }
    return _unselectAllItem;
}

- (UIBarButtonItem *)removeItem
{
    if (!_removeItem) {
        self.removeItem = [[UIBarButtonItem alloc] initWithTitle:MTString(@"删除") style:UIBarButtonItemStyleDone target:self action:@selector(remove)];
    }
    return _removeItem;
}


- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的大小
    layout.itemSize = CGSizeMake(305, 305);
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏的团购";
    self.collectionView.backgroundColor = MTGlobalBg;
    // 左边的返回
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_back" highImage:@"icon_back_highlighted"];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    //第一页的收藏数据
//    [self.deals addObjectsFromArray:[MTDealTool collectDeals:1]];
    
    [TFNotificationCenter addObserver:self selector:@selector(collectStateChange:) name:MTCollectStateDidChangeNotification object:nil];
    
    self.title = @"收藏的团购";
    self.collectionView.backgroundColor = MTGlobalBg;
    
    // 左边的返回
    self.navigationItem.leftBarButtonItems = @[self.backItem];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.alwaysBounceVertical = YES;
    
    // 加载第一页的收藏数据
    [self loadMoreDeals];
   
    // 添加上啦加载
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    
    // 设置导航栏内容
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:MTEdit style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
}

-(void)collectStateChange:(NSNotification *)notification
{
//    TFDeal *deal = notification.userInfo[MTCollectDealKey];
//    if ( [notification.userInfo[MTIsCollectKey] boolValue]) {//收藏成功
//        [self.deals insertObject:deal atIndex:0];
//    }else{//取消收藏成功
//        [self.deals removeObject:deal];
//    }
//    [self.collectionView reloadData];
    
    [self.deals removeAllObjects];
    
    self.currentPage = 0;
    [self loadMoreDeals];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSMutableArray *)deals
{
    if (!_deals) {
        _deals = [NSMutableArray array];
    }
    return _deals;
}



- (UIImageView *)noDataView
{
    if (!_noDataView) {
        // 添加一个"没有数据"的提醒
        UIImageView *noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_collects_empty"]];
        [self.view addSubview:noDataView];
        [noDataView autoCenterInSuperview];
        self.noDataView = noDataView;
    }
    return _noDataView;
}

#pragma mark - navBar
/**
 *  编辑
 */
- (void)edit:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:MTEdit]) {
        item.title = MTDone;
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.selectAllItem, self.unselectAllItem, self.removeItem];
        
        //出现蒙版
        self.collectionView 
        
    } else {
        item.title = MTEdit;
        self.navigationItem.leftBarButtonItems = @[self.backItem];
    }
}


-(void)selectAll
{
    
}

-(void)remove
{
    
}

-(void)unselectAll
{
    
}

- (void)loadMoreDeals
{
    // 1.增加页码
    self.currentPage++;
    
    // 2.增加新数据
    [self.deals addObjectsFromArray:[MTDealTool collectDeals:self.currentPage]];
    
    // 3.刷新表格
    [self.collectionView reloadData];
    
    // 4.结束刷新
    [self.collectionView footerEndRefreshing];
}


/**
 当屏幕旋转,控制器view的尺寸发生改变调用
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // 根据屏幕宽度决定列数
    int cols = (size.width == 1024) ? 3 : 2;
    
    // 根据列数计算内边距
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = (size.width - cols * layout.itemSize.width) / (cols + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    // 设置每一行之间的间距
    layout.minimumLineSpacing = inset;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 计算一遍内边距
    [self viewWillTransitionToSize:CGSizeMake(collectionView.width, 0) withTransitionCoordinator:nil];
    
    // 控制尾部控件的显示和隐藏
    self.collectionView.footerHidden = (self.deals.count == [MTDealTool collectDealsCount]);
    
    // 控制"没有数据"的提醒
    self.noDataView.hidden = (self.deals.count != 0);
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFDetailViewController *detailVc = [[TFDetailViewController alloc] init];
    detailVc.deal = self.deals[indexPath.item];
    [self presentViewController:detailVc animated:YES completion:nil];
}



@end





