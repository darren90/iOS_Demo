//
//  MovieList.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "MovieList.h"

@implementation MovieList


+(instancetype)movieList:(NSString *)name fileType:(FileType)fileType  path:(NSString *)path imgData:(UIImage *)imgData
{
    MovieList *list = [[MovieList alloc]init];
    list.name = name;
    list.fileType = fileType;
    list.path = path;
    list.imgData = imgData;
    return list;
}

@end
