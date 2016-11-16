//
//  DrawerController.h
//  Drawer
//
//  Created by Tengfei on 16/11/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerController : UIViewController

//左边的view
@property (nonatomic, weak, readonly)  UIView *leftView;
//中间的view
@property (nonatomic, weak, readonly)  UIView *rightView;
//右边的view
@property (nonatomic, weak, readonly)  UIView *mainView;

@end
