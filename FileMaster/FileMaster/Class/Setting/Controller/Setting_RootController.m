//
//  SettingViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "Setting_RootController.h"
#import "SettingCell.h"
#import "AboutViewController.h"
#import "SettingModel.h"

@interface Setting_RootController ()
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation Setting_RootController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"设置"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"设置"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000000001;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     SettingModel *model = self.dataArray[indexPath.row];
    if ([model.title isEqualToString:@"应用评分"]) {
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",KAppid];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if  ([model.title isEqualToString:@"关于"]){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AboutViewController *aboutVc = [sb instantiateViewControllerWithIdentifier:@"aboutVc"];
        [self.navigationController pushViewController:aboutVc animated:YES];
    
    }
    
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
        SettingModel *m1 = [SettingModel settingIconName:@"icon_me_review" title:@"应用评分"];
        SettingModel *m2 = [SettingModel settingIconName:@"abouts" title:@"关于"];
        
        [_dataArray addObject:m1];
        [_dataArray addObject:m2];
    }
    return _dataArray;
}

@end



















