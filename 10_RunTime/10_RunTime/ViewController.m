//
//  ViewController.m
//  10_RunTime
//
//  Created by Tengfei on 2017/5/13.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import "ViewController.h"
#import "CommentModel.h"
#import "NSObject+Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"bookmark.plist" ofType:nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
//    NSLog(@"-dict: %@",dict);
    
    //第一种方式 ： 用KVC的方式进行转化
    CommentModel *kvc_m = [CommentModel kvc_modelWith:dict];
    NSLog(@"--:%@",kvc_m);
    
    //第二种方式 ：runtime的方式转化
    CommentModel *rm_m = [CommentModel modelWithDict:dict];
    NSLog(@"--:%@",rm_m);
}


- (void)writeStringToFile {
    
    NSDictionary *dict = @{
                           @"idStr": @"apple_0001",
                           @"text" : @"Agree!Nice weather!",
                           @"user" : @{
                                   @"name" : @"Jack",
                                   @"icon" : @"lufy.png"
                                   },
                           };
    
    // Build the path, and create if needed.
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"--path :  %@",path);
    NSString* fileAtPath = [path stringByAppendingPathComponent:@"bookmark.plist"];
    [dict writeToFile:fileAtPath atomically:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
