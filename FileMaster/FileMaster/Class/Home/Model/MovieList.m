//
//  MovieList.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "MovieList.h"

@implementation MovieList


+(instancetype)movieList:(NSString *)name imgUrl:(NSString *)imgUrl
{
    MovieList *list = [[MovieList alloc]init];
    list.name = name;
    list.imgUrl = imgUrl;
    return list;
}

@end
