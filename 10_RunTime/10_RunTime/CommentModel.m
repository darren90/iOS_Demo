//
//  CommentModel.m
//  10_RunTime
//
//  Created by Tengfei on 2017/5/13.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

  // 用KVC的方式把字典中所有值给模型的属性赋值
+(instancetype)kvc_modelWith:(NSDictionary *)dict{
    CommentModel *m = [[CommentModel alloc]init];
    
    [m setValuesForKeysWithDictionary:dict];
    
    return m;
}

//重写系统方法，防止模型中有些属性在字典中不存在报错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
