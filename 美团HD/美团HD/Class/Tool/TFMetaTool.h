//
//  TFMetaTool.h
//  美团HD
//
//  Created by Tengfei on 16/1/11.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  管理固定的数据
 */
@interface TFMetaTool : NSObject

/**
 *  返回所有的城市
 *
 *  @return 所有的城市
 */
+(NSArray *)cities;


/**
 *  返回搜友的分类数据
 *
 *  @return
 */
+(NSArray *)categories;




/**
 *  返回排序数据
 *
 *  @return
 */
+(NSArray *)sorts;






@end
