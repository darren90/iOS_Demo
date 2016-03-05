//
//  WdCleanCaches.m
//  tools
//
//  Created by Wade on 14-7-6.
//  Copyright (c) 2014年 itcast1. All rights reserved.
//

#import "WdCleanCaches.h"

@implementation WdCleanCaches

+ (NSString *)LibraryDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)DocumentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)PreferencePanesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)CachesDirectory//NSCachesDirectory
{
   return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
// 按路径清除文件
+ (void)clearCachesWithFilePath:(NSString *)path
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
        
}

/**
 *  获取制定路径下，bite的大小
 *
 *  @param path 路径
 *
 *  @return 大小
 */
+ (double)biteSizeWithPaht:(NSString *)path
{
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [mgr subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize*1.0;
    } else { // 文件
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue]*1.0;
    }
}


+ (double)sizeWithFilePaht:(NSString *)path
{
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [mgr subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1000 * 1000.0);
    } else { // 文件
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1000 * 1000.0);
    }
}
/**
 *  删除缓存
 *
 *  @param uniquenName 缓存文件夹名字
 */
+ (void)deleteDownloadFileWithFilePath:(NSString *)uniquenName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/Downloads/%@", documentsDirectory, uniquenName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"error: %@", [error description]);
        }
    }
}

/**
 *   删除Http下载缓存
 *
 *  @param uniquenName 缓存文件名字
 *  @param isDowned    是否下载完毕
 */
+ (void)deleteDownloadHttpFileWithFilePath:(NSString *)uniquenName isDowned:(BOOL)isDowned
{
    //tmpVide
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = @"";
    if (isDowned) {
        filePath = [NSString stringWithFormat:@"%@/Downloads/complete/%@", documentsDirectory, uniquenName];
    }else{
           filePath = [NSString stringWithFormat:@"%@/Downloads/tmpVide/%@", documentsDirectory, uniquenName];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"error: %@", [error description]);
        }
    }
}


/**
 *   删除Http下载缓存2.0
 *
 *  @param uniquenName 缓存文件名字
 *  @param isDowned    是否下载完毕
 */
+ (void)deleteFileModelWithPath:(NSString *)uniquenName isDowned:(BOOL)isDowned
{
    //tmpVide
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = @"";
    if (isDowned) {
        filePath = [NSString stringWithFormat:@"%@/Downloads/Video/%@", documentsDirectory, uniquenName];
    }else{
        filePath = [NSString stringWithFormat:@"%@/Downloads/Temp/%@", documentsDirectory, uniquenName];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"删除缓存失败：error: %@", [error description]);
        }
    }
}

@end
