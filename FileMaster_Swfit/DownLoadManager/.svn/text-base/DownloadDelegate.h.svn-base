//
//  DownloadDelegate.h
//  MovieDownloadManager
//
//  Created by Fengtf on 15/11/4.
//  Copyright © 2015年 ftf. All rights reserved.
//

#ifndef DownloadDelegate_h
#define DownloadDelegate_h

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol DownloadDelegate <NSObject>

-(void)startDownload:(ASIHTTPRequest *)request;
-(void)updateCellProgress:(ASIHTTPRequest *)request;
-(void)finishedDownload:(ASIHTTPRequest *)request;
-(void)allowNextRequest;//处理一个窗口内连续下载多个文件且重复下载的情况
@end


#endif /* DownloadDelegate_h */
