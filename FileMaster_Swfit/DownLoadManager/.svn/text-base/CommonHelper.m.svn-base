//
//  CommonHelper.m
//  MovieDownloadManager
//
//  Created by Fengtf on 15/11/4.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import "CommonHelper.h"
#import "FileModel.h"

#import <CommonCrypto/CommonDigest.h>

@implementation CommonHelper

+ (NSString *)md5StringForData:(NSData*)data{
    // const char *str = [string UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, data.length, r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
}
+ (NSString *)md5StringForString:(NSString*)str{
    const char *str1 = [str UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str1, strlen(str1), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
}


+(NSString *)getFileSizeString:(NSString *)size
{
    long long floatSize = [size longLongValue];
    if(floatSize >= 1024*1024){//大于1M，则转化成M单位的字符串
        return [NSString stringWithFormat:@"%.1fM",floatSize/1024.0/1024];
    }
    else if(floatSize >= 1024 && floatSize < 1024*1024){ //不到1M,但是超过了1KB，则转化成KB单位
        return [NSString stringWithFormat:@"%lldK",floatSize/1024];
    }
    else{//剩下的都是小于1K的，则转化成B单位
        return [NSString stringWithFormat:@"%lldB",floatSize];
    }
}

+(float)getFileSizeNumber:(NSString *)size
{
    NSInteger indexM=[size rangeOfString:@"M"].location;
    NSInteger indexK=[size rangeOfString:@"K"].location;
    NSInteger indexB=[size rangeOfString:@"B"].location;
    if(indexM<1000)//是M单位的字符串
    {
        return [[size substringToIndex:indexM] floatValue]*1024*1024;
    }
    else if(indexK<1000)//是K单位的字符串
    {
        return [[size substringToIndex:indexK] floatValue]*1024;
    }
    else if(indexB<1000)//是B单位的字符串
    {
        return [[size substringToIndex:indexB] floatValue];
    }
    else//没有任何单位的数字字符串
    {
        return [size floatValue];
    }
}

+(NSString *)getDocumentPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
+(NSString *)getTargetPathWithBasepath:(NSString *)name subpath:(NSString *)subpath{
    NSString *pathstr = [[self class]getDocumentPath];
    pathstr = [pathstr stringByAppendingPathComponent:name];
    pathstr = [pathstr stringByAppendingPathComponent:subpath];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    if(![fileManager fileExistsAtPath:pathstr])
    {
        [fileManager createDirectoryAtPath:pathstr withIntermediateDirectories:YES attributes:nil error:&error];
        if(!error)
        {
            NSLog(@"%@",[error description]);
            
        }
    }
    return pathstr;
}
+(NSArray *)getTargetFloderPathWithBasepath:(NSString *)name subpatharr:(NSArray *)arr{
    NSMutableArray *patharr = [NSMutableArray array];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSString *pathstr = [[self class]getDocumentPath];
    pathstr = [pathstr stringByAppendingPathComponent:name];
    for (NSString *str in arr) {
        NSString *path = [pathstr stringByAppendingPathComponent:str];
        
        if(![fileManager fileExistsAtPath:path])
        {
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
            if(!error)
            {
                NSLog(@"%@",[error description]);
                
            }
        }
        [patharr addObject:path];
    }
    
    return patharr;
}
#if 0
+(NSMutableArray *)getAllFinishFilesListWithPatharr:(NSArray *)patharr {
    
    NSMutableArray *finishlist = [NSMutableArray array];
    for (NSString *pathstr in patharr) {
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if( ![fileManager fileExistsAtPath:pathstr]){
            break;
        }
        NSError *error;
        NSArray *filelist=[fileManager contentsOfDirectoryAtPath:pathstr error:&error];
        if(!error)
        {
            NSLog(@"%@",[error description]);
            
        }
        if (filelist ==nil) {
            break;
        }
        for(NSString *fileName in filelist)
        {
            FileModel *finishedFile=[[FileModel alloc] init];
            finishedFile.fileName=fileName;
            finishedFile.targetPath = [pathstr stringByAppendingPathComponent:fileName];
            //根据文件名获取文件的大小
            NSInteger length=[[fileManager contentsAtPath:finishedFile.targetPath] length];
            finishedFile.fileSize=[CommonHelper getFileSizeString:[NSString stringWithFormat:@"%d",length]];
            [finishlist addObject:finishedFile];
        }
    }
    return finishlist;
}
#endif

+(NSString *)getTempFolderPathWithBasepath:(NSString *)name
{
    NSString *pathstr = [[self class]getDocumentPath];
    pathstr = [pathstr stringByAppendingPathComponent:name];
    pathstr =  [pathstr stringByAppendingPathComponent:@"Temp"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    if(![fileManager fileExistsAtPath:pathstr])
    {
        [fileManager createDirectoryAtPath:pathstr withIntermediateDirectories:YES attributes:nil error:&error];
        if(!error)
        {
            NSLog(@"%@",[error description]);
            
        }
    }
    return pathstr;
}

+(BOOL)isExistFile:(NSString *)fileName
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileName];
}

+(float)getProgress:(float)totalSize currentSize:(float)currentSize
{
    return currentSize/totalSize;
}
+(NSDate *)makeDate:(NSString *)birthday
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"MM-dd HH:mm:ss"];//[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //    NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    //    [df setLocale:locale];
    
    NSDate *date=[df dateFromString:birthday];
    //    [ locale release];
    NSLog(@"%@",date);
    return date;
}
+(NSString *)dateToString:(NSDate*)date{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"MM-dd HH:mm:ss"];//[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestr = [df stringFromDate:date];
    return datestr;
}
+(uint64_t)getFreeDiskspace {
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
        NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalFreeSpace;
}
+(uint64_t)getTotalDiskspace {
    uint64_t totalSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalSpace;
}
+(NSString *)getDiskSpaceInfo{
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
    }else
        return nil;
    
    NSString *infostr = [NSString stringWithFormat:@"%.2f GB 可用/总共 %.2f GB", ((totalFreeSpace/1024.0f)/1024.0f)/1024.0f, ((totalSpace/1024.0f)/1024.0f)/1024.0f];
    return infostr;
    
}

@end
