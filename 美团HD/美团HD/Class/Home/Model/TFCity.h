//
//  TFCity.h
//  美团HD
//
//  Created by Tengfei on 16/1/10.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFCity : NSObject


@property (nonatomic,copy)NSString * name;


@property (nonatomic,copy)NSString * pinYin;


@property (nonatomic,copy)NSString * pinYinHead;


/**
 *  TFregion
 */
@property (nonatomic,strong)NSArray * regions;



@end
