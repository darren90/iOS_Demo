//
//  TFSlidePageView.m
//  TFSlidePage
//
//  Created by Tengfei on 16/1/29.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "TFSlidePageView.h"
#import "TFScrollView.h"
 
@interface TFSlidePageView()

@end

@implementation TFSlidePageView

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initSlideSubViews];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSlideSubViews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self layoutSlideSubViews];
}

-(void)initSlideSubViews
{
    
}


-(void)layoutSlideSubViews
{
    
}

@end
