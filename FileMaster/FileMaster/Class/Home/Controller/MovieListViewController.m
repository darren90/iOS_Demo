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
#import "UIImage+Category.h"
 

@interface MovieListViewController ()
- (IBAction)editList:(UIBarButtonItem *)sender;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation MovieListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.dataArray = [self getMovieList];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)getMovieList
{
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:docsDir];
    
    NSString *fileName;
    
    NSMutableArray *array = [NSMutableArray array];
    while (fileName = [dirEnum nextObject]) {
        NSLog(@"FielName : %@" , fileName);
        //        NSLog(@"FileFullPath : %@" , [docsDir stringByAppendingPathComponent:fileName]) ;
        NSString *path = [docsDir stringByAppendingPathComponent:fileName];
        UIImage *imgData ;
        FileType fileType;
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
    MovieListCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"movielistCell"];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieList *model = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (model.fileType == FileMovieCanPlay) {
        MoviePlayerViewController *playerVc = [[MoviePlayerViewController alloc] init];
        playerVc.topTitle = model.name;
        playerVc.playLocalUrl = model.name;
        [self.navigationController presentViewController:playerVc animated:YES completion:nil];
    }else if (model.fileType == FileImage){
        
    }
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

//-(void)getImage{
//    NSString *videoPath= ""
//    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
//    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
//    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//    assetImageGenerator.appliesPreferredTrackTransform = YES;
//    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
//    [asset release];
//    
//    CGImageRef thumbnailImageRef = NULL;
//    CFTimeInterval thumbnailImageTime = 0;
//    NSError *thumbnailImageGenerationError = nil;
//    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 15) actualTime:NULL error:&thumbnailImageGenerationError];
//    [assetImageGenerator release];
//    
//    if (!thumbnailImageRef)
//        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
//    
//    UIImage *thumbnailImage = thumbnailImageRef ? [[[UIImage alloc] initWithCGImage:thumbnailImageRef] autorelease] : nil;
//    //NSData *imageData = UIImagePNGRepresentation(thumbnailImage);
//}



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






