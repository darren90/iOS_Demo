//
//  MovieListViewController.m
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieListCell.h"
#import "MovieList.h"
#import "MoviePlayerViewController.h"
#import "MovieFolderViewController.h"
#import "UIImage+Category.h"
#import "MovieFile.h"


@interface MovieListViewController ()
- (IBAction)editList:(UIBarButtonItem *)sender;

@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation MovieListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    NSMutableArray *pathArray  =[self scanFilesAtPath:docsDir];

    self.dataArray = pathArray;//[self getMovieList];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)scanFilesAtPath:(NSString *)direString {
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
                        imgData = [UIImage imageNamed:@"Finder_files"];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListCell  *cell = [MovieListCell cellWithTableView:tableView];//[tableView dequeueReusableCellWithIdentifier:@"movielistCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieFile *model = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (model.isFolder) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         MovieFolderViewController *folderVc = [sb instantiateViewControllerWithIdentifier:@"folderVc"];
        folderVc.file = model;
        [self.navigationController pushViewController:folderVc animated:YES];
    }else{
        MovieList *list = model.file;
        if (list.fileType == FileMovieCanPlay) {
            MoviePlayerViewController *playerVc = [[MoviePlayerViewController alloc] init];
            playerVc.topTitle = list.name;
            playerVc.playLocalUrl = list.name;
            [self.navigationController presentViewController:playerVc animated:YES completion:nil];
        }else if (list.fileType == FileImage){
            
        }
    }
    
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



/**
    iOS 视频 帧
    http://blog.txx.im/blog/2013/09/04/ios-avassertimagegenerator/
    http://blog.csdn.net/ALDRIDGE1/article/details/24327929
 
*/

/**
 *  编辑视频--：删除+加密
 *
 *  @param sender
 */
- (IBAction)editList:(UIBarButtonItem *)sender {
    
    
    
}
@end






