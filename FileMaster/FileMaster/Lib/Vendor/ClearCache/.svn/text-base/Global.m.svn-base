//
//  Global.m
//  ClearCache
//
//  Created by LXJ on 15/7/20.
//  Copyright (c) 2015年 GOME. All rights reserved.
//

#import "Global.h"

@implementation Global

//计算缓存大小
+ (NSString*)cathSize
{
    NSString *path = [self getFilePathWithCache];
    NSFileManager* manager = [NSFileManager defaultManager];
    
    NSString *message;
    if ([manager fileExistsAtPath:path])
    {
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
        NSString* fileName;
        CGFloat folderSize = 0;
        while ((fileName = [childFilesEnumerator nextObject]) != nil)
        {
            NSString* fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        
        if (folderSize/1024 < 1024)
        {
            message = [NSString stringWithFormat:@"%fKB", folderSize/1024];
        }
        else
        {
            message = [NSString stringWithFormat:@"%.1fMB", folderSize/1024/1024];
        }
    }
    return message;
}

+ (CGFloat)fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (void)clearCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager* manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:[self getFilePathWithCache]])
        {
            NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:[self getFilePathWithCache]] objectEnumerator];
            NSString* fileName;
            while ((fileName = [childFilesEnumerator nextObject]) != nil)
            {
                NSString* fileAbsolutePath = [[self getFilePathWithCache] stringByAppendingPathComponent:fileName];
                [manager removeItemAtPath:fileAbsolutePath error:nil];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self clearCacheSuccess];
            
        });

    });
}

+ (void)clearCacheSuccess {
    
    NSLog(@"清除缓存成功");
}

+ (NSString *)getFilePathWithCache {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

@end
