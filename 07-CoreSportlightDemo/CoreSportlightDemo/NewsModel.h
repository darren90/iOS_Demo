//
//  NewsModel.h
//  CoreSportlightDemo
//
//  Created by Tengfei on 16/2/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject


@property (nonatomic,copy)NSString * sId;


@property (nonatomic,copy)NSString * title;


@property (nonatomic,copy)NSString * imgUrl;


@property (nonatomic,copy)NSString * webUrl;

+(instancetype)newsWithsId:(NSString *)sId title:(NSString *)title imgUrl:(NSString *)imgUrl webUrl:(NSString *)webUrl;

@end
