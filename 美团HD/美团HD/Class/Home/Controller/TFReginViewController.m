//
//  DistrictViewController.m
//  美团HD
//
//  Created by Tengfei on 16/1/9.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFReginViewController.h"
#import "TFHomeDropdown.h"
#import "Masonry.h"
#import "TFCityViewController.h"
#import "BaseNavigationController.h"
#import "TFMetaTool.h"
//#import "TFCityGroup.h"
#import "TFregion.h"
#import "TFConst.h"

@interface TFReginViewController ()<TFHomeDropdownDataSource,TFHomeDropdownDelegate>
@property (weak, nonatomic) IBOutlet UIView *titleView;
- (IBAction)changeCity:(UIButton *)sender;

@end

@implementation TFReginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TFHomeDropdown *dropdown = [TFHomeDropdown dropDown];
    [self.view addSubview:dropdown];
//    dropdown.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    [dropdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    dropdown.dataSource = self;
    dropdown.delegate = self;
//    dropdown.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TFHomeDropdownDataSource
-(NSInteger)numofRowsInMainTable:(TFHomeDropdown *)homeDropdown
{
    return self.regions.count;
}

-(NSString *)homeDropdown:(TFHomeDropdown *)homeDropdown titleForInMainTable:(int)row
{
    TFregion  *region = self.regions[row];
    return region.name;
}


-(NSArray *)homeDropdown:(TFHomeDropdown *)homeDropdown subDataForInMainTable:(int)row
{
    TFregion  *region = self.regions[row];
    return region.subregions;
}

#pragma mark  - TFHomeDropdownDelegate
-(void)homeDropdown:(TFHomeDropdown *)homeDropdown didSelectRowInMainTable:(int)row
{
    TFregion *region = self.regions[row];
    //    NSLog(@"---category:%@",category.name);
    if (region.subregions.count == 0) {//发出通知
        [TFNotificationCenter postNotificationName:TFReginDidSelectNotification object:nil userInfo:@{TFSelectReginName : region}];
    }
}

-(void)homeDropdown:(TFHomeDropdown *)homeDropdown didSelectRowInSubTable:(int)row inMainTable:(int)mainRow
{
    TFregion *region = self.regions[row];
    //    NSLog(@"--sub--category:%@",category.subcategories[row]);
    [TFNotificationCenter postNotificationName:TFReginDidSelectNotification object:nil userInfo:@{TFSelectReginName : region, TFSelectSubReginName: region.subregions[row]}];
}



- (IBAction)changeCity:(UIButton *)sender {
    TFCityViewController *city = [[TFCityViewController alloc]init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:city];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
}
@end
