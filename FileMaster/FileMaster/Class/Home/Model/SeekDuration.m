//
//  SeekDuration.m
//  FileMaster
//
//  Created by Fengtf on 16/3/4.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "SeekDuration.h"

@implementation SeekDuration


+(NSNumber *)getDurationWithName:(NSString *)name{
//    NSString *path = [self getPlistPath];
//    SeekDuration *model =[NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    return model.duration;
    
    NSString *path = [self getPlistPath];;
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSArray *result = [NSArray arrayWithContentsOfFile:path];
    NSNumber *duration = dict[name];
    return duration;
}

+(void)saveDuration:(NSString *)name duration:(NSNumber *)duration{
//    SeekDuration *model = [[SeekDuration alloc]init];
//    model.duration = duration;
//    model.name = name;
//    NSString *path = [self getPlistPath];
//    [NSKeyedArchiver archiveRootObject:model toFile:path];
    
    NSString *path = [self getPlistPath];
    
    NSDictionary *dict = @{name : duration};
    
   BOOL resutlt = [dict writeToFile:path atomically:YES];
    NSLog(@"%d",resutlt);
}


+(NSString *)getPlistPath{
    //let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).last!
    //let path1 = path as NSString
    //let filePath = path1.stringByAppendingPathComponent("account.plist")
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return [path stringByAppendingPathComponent:@"seekDuration.plist"];
}


//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:self.name forKey:@"name"];
//    [aCoder encodeObject:self.duration forKey:@"duration"];
//}
//- (id)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//        self.name = [aDecoder decodeObjectForKey:@"duration"];
//    }
//    return self;
//}

@end
