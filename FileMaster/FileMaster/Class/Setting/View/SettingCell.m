//
//  SettingCell.m
//  FileMaster
//
//  Created by Tengfei on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SettingCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
