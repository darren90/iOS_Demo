//
//  TFHomeDropdown.m
//  美团HD
//
//  Created by Tengfei on 16/1/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFHomeDropdown.h"
#import "TFCategory.h"
#import "MTHomeDropdownSubCell.h"
#import "MTHomeDropdownMainCell.h"

@interface TFHomeDropdown()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

/**
 *  选中的类别-左边
 */
@property (nonatomic,strong)TFCategory * selectedCategory;

@end

@implementation TFHomeDropdown

+(instancetype)dropDown
{
    return [[[NSBundle mainBundle]loadNibNamed:@"TFHomeDropdown" owner:nil options:nil] firstObject];
}

-(void)setCategories:(NSArray *)categories
{
    _categories = categories;
    
    [self.mainTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return self.categories.count;
    }else{
       return self.selectedCategory.subcategories.count;
    }
}

 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        cell = [MTHomeDropdownMainCell cellWithTableView:tableView];
      
        TFCategory *category = self.categories[indexPath.row];
        cell.textLabel.text = category.name;
        cell.imageView.image = [UIImage imageNamed:category.small_icon];
        if (category.subcategories.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else{
        cell = [MTHomeDropdownSubCell cellWithTableView:tableView];
        
        NSString *name = self.selectedCategory.subcategories[indexPath.row];
        cell.textLabel.text = name;
//        cell.imageView.image = [UIImage imageNamed:category.small_icon];
    }
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        TFCategory *category = self.categories[indexPath.row];
//        if (category.subcategories.count) {//刷新右边数据
            self.selectedCategory = category;
//        }
        [self.subTableView reloadData];
    }
}


@end
