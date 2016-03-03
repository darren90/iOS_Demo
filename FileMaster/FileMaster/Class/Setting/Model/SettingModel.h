//
//  SettingModel.h
//  FileMaster
//
//  Created by Tengfei on 16/3/4.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingModel : NSObject


@property (nonatomic,copy)NSString * iconName;


@property (nonatomic,copy)NSString * title;


//@property (nonatomic,copy)NSString * ;


+(instancetype)settingIconName:(NSString *)iconName title:(NSString *)title;


@end
