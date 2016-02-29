//
//  NewsModel.m
//  CoreSportlightDemo
//
//  Created by Tengfei on 16/2/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+(instancetype)newsWithsId:(NSString *)sId title:(NSString *)title imgUrl:(NSString *)imgUrl webUrl:(NSString *)webUrl{
    NewsModel *model = [[NewsModel alloc]init];
    model.sId = sId;
    model.title = title;
    model.imgUrl = imgUrl;
    model.webUrl = webUrl;
    return model;
}

@end
