//
//  GetFilesTools.h
//  FileMaster
//
//  Created by Fengtf on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetFilesTools : NSObject

+ (NSMutableArray *)scanMoviesAtPath:(NSString *)direString;

+ (NSMutableArray *)scanFilesAtPath:(NSString *)direString;


@end
