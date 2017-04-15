//
//  ImageModel.h
//  09-多图片多线程下载
//
//  Created by Tengfei on 2017/4/15.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject


@property (nonatomic,copy)NSString * name;

@property (nonatomic,copy)NSString * url;


+(instancetype)modelWithDict:(NSDictionary *)dict;

@end
