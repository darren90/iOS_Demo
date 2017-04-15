//
//  ImageModel.m
//  09-多图片多线程下载
//
//  Created by Tengfei on 2017/4/15.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

+(instancetype)modelWithDict:(NSDictionary *)dict{
    ImageModel *m = [[ImageModel alloc]init];
    [m setValuesForKeysWithDictionary:dict];
    return m;
}

@end
