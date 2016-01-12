//
//  CategoryController.m
//  美团HD
//
//  Created by Tengfei on 16/1/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "CategoryController.h"
#import "TFHomeDropdown.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "TFCategory.h"
#import "TFMetaTool.h"
#import "TFConst.h"

@interface CategoryController ()<TFHomeDropdownDataSource,TFHomeDropdownDelegate>

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载分类数据
//    NSString *file = [[NSBundle mainBundle]pathForResource:@"categories.plist" ofType:nil];
//    NSArray *dictArray = [NSArray arrayWithContentsOfFile:file];
//    NSArray *categories = [TFCategory objectArrayWithKeyValuesArray:dictArray];
//    NSArray *categories = [TFCategory objectArrayWithFilename:@"categories.plist"];
    
    TFHomeDropdown *dropdown = [TFHomeDropdown dropDown];
    [self.view addSubview:dropdown];
    dropdown.frame = self.view.bounds;
//    dropdown.categories = categories;
    dropdown.dataSource = self;
    dropdown.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TFHomeDropdownDataSource
-(NSInteger)numofRowsInMainTable:(TFHomeDropdown *)homeDropdown
{
    return [TFMetaTool categories].count;
}

-(NSString *)homeDropdown:(TFHomeDropdown *)homeDropdown titleForInMainTable:(int)row
{
    TFCategory *category = [TFMetaTool categories][row];
    return category.name;
}

-(NSString *)homeDropdown:(TFHomeDropdown *)homeDropdown iconForInMainTable:(int)row
{
    TFCategory *category = [TFMetaTool categories][row];
    return category.small_icon;
}

-(NSString *)homeDropdown:(TFHomeDropdown *)homeDropdown selectIconForInMainTable:(int)row
{
    TFCategory *category = [TFMetaTool categories][row];
    return category.small_highlighted_icon;
}
-(NSArray *)homeDropdown:(TFHomeDropdown *)homeDropdown subDataForInMainTable:(int)row
{
    TFCategory *category = [TFMetaTool categories][row];
    return category.subcategories;
}

#pragma mark  - TFHomeDropdownDelegate
-(void)homeDropdown:(TFHomeDropdown *)homeDropdown didSelectRowInMainTable:(int)row
{
    TFCategory *category = [TFMetaTool categories][row];
//    NSLog(@"---category:%@",category.name);
    if (category.subcategories.count == 0) {//发出通知
        [TFNotificationCenter postNotificationName:TFCategoryDidSelectNotification object:nil userInfo:@{TFSelectCategoryName : category}];
    }
}

-(void)homeDropdown:(TFHomeDropdown *)homeDropdown didSelectRowInSubTable:(int)row inMainTable:(int)mainRow
{
    TFCategory *category = [TFMetaTool categories][mainRow];
//    NSLog(@"--sub--category:%@",category.subcategories[row]);
    [TFNotificationCenter postNotificationName:TFCategoryDidSelectNotification object:nil userInfo:@{TFSelectCategoryName : category, TFSelectSubCategoryName: category.subcategories[row]}];
}



@end






