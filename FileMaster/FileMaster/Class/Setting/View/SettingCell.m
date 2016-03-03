//
//  SettingCell.m
//  FileMaster
//
//  Created by Tengfei on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "SettingCell.h"
#import "SettingModel.h"

@interface SettingCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

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
    self.iconView.clipsToBounds = YES;
}

-(void)setModel:(SettingModel *)model
{
    _model = model;
    
    self.iconView.image = [UIImage imageNamed:model.iconName];
    self.nameLabel.text = model.title;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
