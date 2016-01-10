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

@interface TFCityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray * cities;

@end

@implementation TFCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" highImage:@"btn_navigation_close_hl"];
    
    
    //加载城市数据
    NSArray *cities = [TFCity objectArrayWithFilename:@"cities.plist"];
    self.cities = [NSArray array];
    self.cities = cities;
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cities.count;
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
    TFCity *city = self.cities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

@end
