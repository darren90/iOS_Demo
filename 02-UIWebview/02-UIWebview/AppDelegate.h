//
//  AppDelegate.h
//  02-UIWebview
//
//  Created by Fengtf on 15/7/14.
//  Copyright (c) 2015年 rrmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/***  是否允许横屏的标记 */
@property (nonatomic,assign)BOOL allowRotation;

@end

