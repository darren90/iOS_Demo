//
//  GetFilesTools.m
//  FileMaster
//
//  Created by Fengtf on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "GetFilesTools.h"
#import "MovieList.h"
#import "UIImage+Category.h"
#import "MovieFile.h"

@implementation GetFilesTools



+ (NSMutableArray *)scanFilesAtPath:(NSString *)direString {
    NSMutableArray *pathArray = [NSMutableArray array];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *tempArray = [fileManager contentsOfDirectoryAtPath:direString error:nil];
    for (NSString *fileName in tempArray) {
        MovieFile *movieFile = [[MovieFile alloc]init];
        
        UIImage *imgData ;
        FileType fileType;
        MovieList *model;
        
        BOOL flag = YES;
        NSString *fullPath = [direString stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                // ignore .DS_Store
                if (![[fileName substringToIndex:1] isEqualToString:@"."]) {
                    
                    if ([fileName hasSuffix:@".mp4"]) {
                        imgData = [UIImage thumbnailImageForVideo:[NSURL fileURLWithPath:fullPath] atTime:10.0];
                        fileType = FileMovieCanPlay;
                    }else if([fileName hasSuffix:@".png"]){
                        imgData = [UIImage imageWithContentsOfFile:fullPath];
                        fileType = FileImage;
                    }else {
                        imgData = [UIImage imageNamed:@"ffile"];
                        fileType = FileOther;
                    }
                    model = [MovieList movieList:fileName fileType:fileType path:fullPath imgData:imgData];
                    
                    movieFile.isFolder = NO;
                    movieFile.file = model;
                    
                    [pathArray addObject:movieFile];
                }
            }
            else {
                movieFile.isFolder = YES;
                movieFile.subFiles = [self scanFilesAtPath:fullPath];
                movieFile.folderName = fileName;
                //                [pathArray addObject:[self scanFilesAtPath:fullPath]];
                [pathArray addObject:movieFile];
            }
        }
    }
    return pathArray;
}







- (NSMutableArray *)getMovieList
{
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:docsDir];
    
    NSString *fileName;
    
    NSMutableArray *array = [NSMutableArray array];
    while (fileName = [dirEnum nextObject]) {
        NSString *path = [docsDir stringByAppendingPathComponent:fileName];
        
        //        NSLog(@"FileFullPath : %@" , [docsDir stringByAppendingPathComponent:fileName]) ;
        NSLog(@"FielName : %@" , fileName);
        
        UIImage *imgData ;
        FileType fileType;
        
        NSString *subPath = [NSString stringWithFormat:@"%@%@",path,fileName];
        BOOL flag ;
        [fileManager fileExistsAtPath:subPath isDirectory:&flag];
        if(flag == YES){//是文件夹
            [dirEnum skipDescendants];
            fileType = FileFolder;
            imgData = [UIImage imageNamed:@"Finder_folder"];
        }else{
            
        }
        
        if ([fileName hasSuffix:@".mp4"]) {
            imgData = [UIImage thumbnailImageForVideo:[NSURL fileURLWithPath:path] atTime:10.0];
            fileType = FileMovieCanPlay;
        }else if([fileName hasSuffix:@".png"]){
            imgData = [UIImage imageWithContentsOfFile:path];
            fileType = FileImage;
        }else {
            imgData = [UIImage imageNamed:@"Finder_files"];
            fileType = FileOther;
        }
        
        MovieList *model = [MovieList movieList:fileName fileType:fileType path:path imgData:imgData];
        
        [array addObject:model];
    }
    return array;
}

- (void)logFilePathInDocumentsDir
{
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:docsDir];
    
    NSString *fileName;
    
    while (fileName = [dirEnum nextObject]) {
        NSLog(@"FielName : %@" , fileName);
        NSLog(@"FileFullPath : %@" , [docsDir stringByAppendingPathComponent:fileName]) ;
    }
}


- (NSMutableArray *)allFilesAtPath:(NSString *)direString
{
    NSMutableArray *pathArray = [NSMutableArray array];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *tempArray = [fileManager contentsOfDirectoryAtPath:direString error:nil];
    for (NSString *fileName in tempArray) {
        BOOL flag = YES;
        NSString *fullPath = [direString stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                // ignore .DS_Store
                if (![[fileName substringToIndex:1] isEqualToString:@"."]) {
                    [pathArray addObject:fullPath];
                }
            }
            else {
                [pathArray addObject:[self allFilesAtPath:fullPath]];
            }
        }
    }
    
    return pathArray;
}



@end





