//
//  MovieList.h
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    FileMovieCanPlay,
    FileMovieCanNotPlay,
    FileImage,
    FileZIP,
    FileFolder,
    FileOther
} FileType;
@interface MovieList : NSObject

@property (nonatomic,copy)NSString * name;

@property (nonatomic,assign)FileType fileType;
@property (nonatomic,strong)UIImage *imgData;

@property (nonatomic,copy)NSString * path;

+(instancetype)movieList:(NSString *)name fileType:(FileType)fileType path:(NSString *)path imgData:(UIImage *)imgData;

@end
