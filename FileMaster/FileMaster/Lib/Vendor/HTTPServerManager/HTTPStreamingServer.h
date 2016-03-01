//
//  HTTPStreamingServer.h
//  PUClient
//
//  Created by Fengtf on 15/9/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPStreamingServer : NSObject
+ (instancetype)sharedInstance;

/** 启动本地local服务  */
- (void)start;
/** 关闭本地local服务 */
- (void)stop;
/**
 *  服务是否启动了
 *
 *  @return YES：启动了；NO：没有启动
 */
-(BOOL)isStart;
@end
