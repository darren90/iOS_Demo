//
//  WdCleanCaches.h
//  tools
//
//  Created by Wade on 14-7-6.
//  Copyright (c) 2014年 itcast1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WdCleanCaches : NSObject

/**
 *  返回path路径下文件的文件大小。
 */
+ (double)sizeWithFilePaht:(NSString *)path;

/**
 *  删除path路径下的文件。
 */
+ (void)clearCachesWithFilePath:(NSString *)path;

/**
 *  获取沙盒Library的文件目录。
 */
+ (NSString *)LibraryDirectory;

/**
 *  获取沙盒Document的文件目录。
 */
+ (NSString *)DocumentDirectory;

/**
 *  获取沙盒Preference的文件目录。
 */
+ (NSString *)PreferencePanesDirectory;

/**
 *  获取沙盒Caches的文件目录。
 */
+ (NSString *)CachesDirectory;

/**
 *  删除视频下载缓存
 *
 *  @param uniquenName 缓存文件夹名字
 */
+ (void)deleteDownloadFileWithFilePath:(NSString *)uniquenName;
/**
 *   删除Http下载缓存
 *
 *  @param uniquenName 缓存文件名字
 *  @param isDowned    是否下载完毕
 */
+ (void)deleteDownloadHttpFileWithFilePath:(NSString *)uniquenName isDowned:(BOOL)isDowned;


/**
 *   删除Http下载缓存2.0
 *
 *  @param uniquenName 缓存文件名字
 *  @param isDowned    是否下载完毕
 */
+ (void)deleteFileModelWithPath:(NSString *)uniquenName isDowned:(BOOL)isDowned;

/**
 *  获取制定路径下，bite的大小
 *
 *  @param path 路径
 *
 *  @return 大小
 */
+ (double)biteSizeWithPaht:(NSString *)path;
@end
