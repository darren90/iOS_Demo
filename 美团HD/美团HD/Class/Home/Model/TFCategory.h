//
//  TFCategory.h
//  美团HD
//
//  Created by Tengfei on 16/1/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TFHomeDropdown.h"

@interface TFCategory : NSObject

@property (nonatomic,copy)NSString * name;
/**
 *  子类别
 */
@property (nonatomic,strong)NSArray * subcategories;


/**
 *  显示在导航栏的大图标
 */
@property (nonatomic,copy)NSString * highlighted_icon;

@property (nonatomic,copy)NSString * icon;


@property (nonatomic,copy)NSString * small_highlighted_icon;


@property (nonatomic,copy)NSString * small_icon;

/**
 *  显示在地图上的图标
 */
@property (nonatomic,copy)NSString * map_icon;




@end
