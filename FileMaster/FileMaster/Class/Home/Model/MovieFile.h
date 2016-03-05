//
//  MovieFile.h
//  FileMaster
//
//  Created by Tengfei on 16/3/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MovieList;
@interface MovieFile : NSObject


@property (nonatomic,assign)BOOL isFolder;

/**
 *  isFolder = YES ，这个才有值
 */
@property (nonatomic,copy)NSString * folderName;

/**
 *  isFolder = YES ，这个才有值
 */
@property (nonatomic,strong)NSArray * subFiles;

/**
 *  这个文件夹的路径
 */
@property (nonatomic,copy)NSString * path;


/**
 *  isFolder = NO ，这个才有值
 */
@property (nonatomic,strong)MovieList *file;



@end
