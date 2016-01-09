//
//  TFHomeDropdown.m
//  美团HD
//
//  Created by Tengfei on 16/1/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFHomeDropdown.h"
#import "TFCategory.h"


@interface TFHomeDropdown()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

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
    return self.categories.count;
}

 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1,创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID ];
    }
    //2,设置cell的数据
    TFCategory *category = self.categories[indexPath.row];
    cell.textLabel.text = category.name;
    cell.imageView.image = [UIImage imageNamed:category.small_icon];
    if (category.subcategories.count) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFCategory *category = self.categories[indexPath.row];
    
    if (category.subcategories.count) {//刷新右边数据
        
    }else{

    }
}


@end
