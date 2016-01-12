//
//  TFHomeDropdown.m
//  美团HD
//
//  Created by Tengfei on 16/1/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFHomeDropdown.h"
//#import "TFCategory.h"
#import "MTHomeDropdownSubCell.h"
#import "MTHomeDropdownMainCell.h"

@interface TFHomeDropdown()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

/**
 *  选中的类别-左边
 */

@property (nonatomic,assign)NSInteger selectRow;

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
        return [self.dataSource numofRowsInMainTable:self];
    }else{
        return [self.dataSource homeDropdown:self subDataForInMainTable:self.selectRow].count;
    }
}

 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        cell = [MTHomeDropdownMainCell cellWithTableView:tableView];
      
        //取出模型数据
        
        cell.textLabel.text = [self.dataSource homeDropdown:self titleForInMainTable:indexPath.row];
        NSArray *subData = [self.dataSource homeDropdown:self subDataForInMainTable:indexPath.row];
        
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:iconForInMainTable:)]) {
            cell.imageView.image = [UIImage imageNamed:[self.dataSource homeDropdown:self iconForInMainTable:indexPath.row]];
        }
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:selectIconForInMainTable:)]) {
            cell.imageView.highlightedImage = [UIImage imageNamed:[self.dataSource homeDropdown:self selectIconForInMainTable:indexPath.row]];
        }
        if (subData.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else{
        cell = [MTHomeDropdownSubCell cellWithTableView:tableView];
        
        NSArray *subData = [self.dataSource homeDropdown:self subDataForInMainTable:self.selectRow];
        cell.textLabel.text = subData[indexPath.row];
//        cell.imageView.image = [UIImage imageNamed:category.small_icon];
    }
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        self.selectRow = indexPath.row;
        
        [self.subTableView reloadData];
        
        //通知代理
        if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectRowInMainTable:)]) {
            [self.delegate homeDropdown:self didSelectRowInMainTable:indexPath.row];
        }
    }else{
        //通知代理
        if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectRowInSubTable:inMainTable:)]) {
            [self.delegate homeDropdown:self didSelectRowInSubTable:indexPath.row inMainTable:self.selectRow];
        }
    }
}


@end
