//
//  SettingModel.m
//  FileMaster
//
//  Created by Tengfei on 16/3/4.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "SettingModel.h"

@implementation SettingModel


+(instancetype)settingIconName:(NSString *)iconName title:(NSString *)title{
    SettingModel *model = [[SettingModel alloc]init];
    model.iconName = iconName;
    model.title = title;
    return model;
}

@end
