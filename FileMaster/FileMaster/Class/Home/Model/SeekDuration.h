//
//  SeekDuration.h
//  FileMaster
//
//  Created by Fengtf on 16/3/4.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeekDuration : NSObject//<NSCoding>

/**
 *  名字
 */
@property (nonatomic,copy)NSString * name;

/**
 *  时间
 */
@property (nonatomic,strong)NSNumber *duration;


+(NSNumber *)getDurationWithName:(NSString *)name;

+(void)saveDuration:(NSString *)name duration:(NSNumber *)duration;

@end
