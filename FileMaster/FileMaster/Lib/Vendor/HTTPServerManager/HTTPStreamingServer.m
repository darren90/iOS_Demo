//
//  HTTPStreamingServer.m
//  PUClient
//
//  Created by Fengtf on 15/9/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//
#import "HTTPServer.h"
#import "HTTPStreamingServer.h"

#define kDownDomanPath @"Downloads"  //下载的地址

@interface HTTPStreamingServer()
@property (nonatomic, strong) HTTPServer *httpServer;
@end

@implementation HTTPStreamingServer

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance initialize];
    });
    
    return sharedInstance;
}

- (void)initialize {
    self.httpServer = [[HTTPServer alloc] init];
    [self.httpServer setType:@"_http._tcp."];
    [self.httpServer setPort:12345];
    //NSDocumentDirectory
    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *webPath = [pathPrefix stringByAppendingPathComponent:kDownDomanPath];
    
    NSLog(@"%@",pathPrefix);
    NSLog(@"%@",webPath);
    [self.httpServer setDocumentRoot:pathPrefix];
}

- (void)start {
    
    NSError *error;
    if([self.httpServer start:&error])  {
        NSLog(@"Started HTTP Server on port %hu", [self.httpServer listeningPort]);
    }else  {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
}

- (void)stop {
    [self.httpServer stop];
}

/**
 *  服务是否启动了
 *
 *  @return YES：启动了；NO：没有启动
 */
-(BOOL)isStart
{
   return [self.httpServer isRunning];
}

@end
