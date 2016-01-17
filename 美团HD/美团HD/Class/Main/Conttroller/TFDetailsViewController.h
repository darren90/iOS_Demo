//
//  TFDetailsViewController.h
//  美团HD
//
//  Created by Tengfei on 16/1/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//


/**
 *  团购列表的积累
 */
#import <UIKit/UIKit.h>

@interface TFDetailsViewController : UICollectionViewController

/**
 *  设置请求参数:交给子类去实现
 */
- (void)setupParams:(NSMutableDictionary *)params;

@end
