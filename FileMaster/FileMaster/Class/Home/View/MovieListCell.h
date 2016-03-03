//
//  MovieListCell.h
//  FileMaster
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieFile;
@interface MovieListCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)MovieFile * model;


@end
