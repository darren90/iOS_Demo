//
//  ForwardBackView.h
//  PUClient
//
//  Created by RRLhy on 15/10/29.
//  Copyright © 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ForwardDirection) {
    ForwardUp = 0,
    ForwardBack = 1,
};

@interface ForwardBackView : UIView

@property (nonatomic,assign)ForwardDirection  direction;

@property (nonatomic,copy)NSString * time;

@end
