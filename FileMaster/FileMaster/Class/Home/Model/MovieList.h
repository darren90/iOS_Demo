//
//  MovieList.h
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieList : NSObject


@property (nonatomic,copy)NSString * name;

@property (nonatomic,copy)NSString * imgUrl;

+(instancetype)movieList:(NSString *)name imgUrl:(NSString *)imgUrl;

@end
