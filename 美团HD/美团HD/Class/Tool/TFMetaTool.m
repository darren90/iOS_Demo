//
//  TFMetaTool.m
//  美团HD
//
//  Created by Tengfei on 16/1/11.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFMetaTool.h"
#import "MJExtension.h"
#import "TFCityGroup.h"
#import "TFCategory.h"
#import "TFCity.h"
#import "TFSort.h"

@implementation TFMetaTool

static NSArray *_cities;

+(NSArray *)cities
{
    if (_cities == nil) {
        _cities = [TFCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}



static NSArray *_categories;

+(NSArray *)categories
{
    if (_categories == nil) {
        _categories = [TFCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}


static NSArray *_sorts;

+(NSArray *)sorts
{
    if (_sorts == nil) {
        _sorts = [TFSort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}
@end
