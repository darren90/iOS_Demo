//
//  AllFiles_RootController.m
//  FileMaster
//
//  Created by Tengfei on 16/3/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "AllFiles_RootController.h"
#import "MovieListCell.h"
#import "MovieList.h"
#import "MoviePlayerViewController.h"
#import "MovieFolderViewController.h"
#import "UIImage+Category.h"
#import "MovieFile.h"
#import "GetFilesTools.h"
@interface AllFiles_RootController ()

- (IBAction)editList:(UIBarButtonItem *)sender;

@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation AllFiles_RootController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    NSMutableArray *pathArray =  [GetFilesTools scanFilesAtPath:docsDir];//[self scanFilesAtPath:docsDir];
    
    self.dataArray = pathArray;//[self getMovieList];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView在编辑模式下可以多选，并且只需设置一次
//    self.tableView.allowsMultipleSelectionDuringEditing = YES;
   
    //滑动隐藏navBar
//    self.navigationController.hidesBarsOnSwipe = YES;
    
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    if (tableView.isEditing)    return ;
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieFile *file = self.dataArray[indexPath.row];
    MovieList *model = file.file;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //1：局部删除一行的刷新
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        if (file.isFolder) {
            [WdCleanCaches deleteDownloadFileWithFilePath:file.path];
        }else{
            [WdCleanCaches deleteDownloadFileWithFilePath:model.path];
        }
    }

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
    sender.title = self.tableView.isEditing ? @"编辑" : @"完成" ;

    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    
    
}
@end
