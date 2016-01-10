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
#import "TFCity.h"
#import "MJExtension.h"
#import "TFCityGroup.h"
#import "Masonry.h"


static int TFCoverTag = 999;

@interface TFCityViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic,strong)NSArray * cities;

@property (nonatomic,weak)UIView *cover;

@end

@implementation TFCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" highImage:@"btn_navigation_close_hl"];
//    self.tableView.sectionIndexBackgroundColor = [UIColor blackColor];
    self.tableView.sectionIndexColor = [UIColor blackColor];
    
    //加载城市数据
    NSArray *cities = [TFCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    self.cities = [NSArray array];
    self.cities = cities;
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cities.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TFCityGroup *citys = self.cities[section];
    return citys.cities.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //1,创建cell
    static NSString *ID = @"cities";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
    }
    //2,设置cell的数据
//    TFCity *city = self.cities[indexPath.row];
    TFCityGroup *cityGroup = self.cities[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TFCityGroup *citys = self.cities[section];
    return citys.title;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    NSMutableArray *titles = [NSMutableArray array];
//    for (TFCityGroup *group in self.cities) {
//        [titles addObject:group.title];
//    }
//    return titles;
    
    
    //黑科技  kvc
    return [self.cities valueForKeyPath:@"title"];
}


#pragma mark - searchbar的代理

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //遮盖
    UIView *cover = [[UIView alloc]init];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.5;
    [self.view addSubview:cover];
    cover.tag = TFCoverTag;
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self.searchBar action:@selector(resignFirstResponder)];
    [cover addGestureRecognizer:tap];
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(self.tableView.mas_top);
        make.right.equalTo(self.tableView.mas_right);
        make.bottom.equalTo(self.tableView.mas_bottom);
    }];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [[self.view viewWithTag:TFCoverTag] removeFromSuperview];
}

@end












