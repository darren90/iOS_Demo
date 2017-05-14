//
//  NSObject+Model.m
//  10_RunTime
//
//  Created by Tengfei on 2017/5/13.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

+(instancetype)modelWithDict:(NSDictionary *)dict{
    
    id model = [[self alloc]init];
    
    unsigned int outCount = 0;
    //获取变量列表
    Ivar * ivars = class_copyIvarList(self, &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        
        NSString *ivarKey = [NSString stringWithUTF8String:name];
        NSString *ivarType = [NSString stringWithUTF8String:type];
        
        //类型: @"NSString" 值: _idStr
        //类型: @"UserModel" 值: _userModel
        
        //不进行转化前，类型是@""
//        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@\"" withString:@""];
//        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];

        NSLog(@"type: %@ key: %@ ",ivarType, ivarKey);

        
        //获取key 截取_ 下划线
        NSString *key = [ivarKey substringFromIndex:1];
        //获取value
        id value = dict[key];
        
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            Class ms = NSClassFromString(ivarType);
            value = [ms modelWithDict:value];
        }
        
        if (value) {
            [model setValue:value forKey:key];
        }
    }
    free(ivars);
    return model;
}

@end
