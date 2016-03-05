//
//  MovieList.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "MovieList.h"

@implementation MovieList


-(void)setPath:(NSString *)path{
    _path = path;
    
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    int leng = path.length;
    NSRange otherRange = NSMakeRange(docsDir.length+1, path.length - docsDir.length-1);
    self.relaPath = [path substringWithRange:otherRange];
    
}


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
