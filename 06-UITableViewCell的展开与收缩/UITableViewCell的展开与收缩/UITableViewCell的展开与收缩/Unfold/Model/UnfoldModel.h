//
//  UnfoldModel.h
//  UITableViewCell的展开与收缩
//
//  Created by Fengtf on 15/12/28.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnfoldModel : NSObject

@property (nonatomic,copy)NSString * contenxt;

/**
 *  是否是折叠的，YES：是。NO：没有折叠
 */
@property (nonatomic,assign)BOOL isUnflod;

@end
