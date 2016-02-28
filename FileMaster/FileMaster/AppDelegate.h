//
//  AppDelegate.h
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/***  是否允许横屏的标记 Yes:允许，NO:不允许 */
@property (nonatomic,assign)BOOL allowRotation;


@end

