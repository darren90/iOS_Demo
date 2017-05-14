//
//  CommentModel.h
//  10_RunTime
//
//  Created by Tengfei on 2017/5/13.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface CommentModel : NSObject

@property (nonatomic,copy) NSString *idStr;

@property (nonatomic,copy) NSString *text;

//@property (nonatomic,strong) NSDictionary *user;

@property (nonatomic,strong) UserModel *user;

+(instancetype)kvc_modelWith:(NSDictionary *)dict;

@end
