//
//  SettingCell.h
//  FileMaster
//
//  Created by Tengfei on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingModel;
@interface SettingCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)SettingModel *model;

@end
