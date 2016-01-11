//
//  TFSearchResultController.m
//  美团HD
//
//  Created by Tengfei on 16/1/10.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "TFSearchResultController.h"
#import "TFCity.h"
#import "MJExtension.h"
#import "TFConst.h"

@interface TFSearchResultController ()

@property (nonatomic,strong)NSArray * cities;


@property (nonatomic,strong)NSArray  * resultCites;

@end

@implementation TFSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(NSArray *)cities
{
    if (!_cities) {
        _cities = [NSArray array];
        _cities = [TFCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

-(void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    
    searchText = searchText.lowercaseString;
    //根据关键字，搜索数据
//    NSLog(@"--searchText:%@",searchText);
    self.resultCites = [NSArray array];
    
//    for (TFCity *city in self.cities) {
//        if ([city.name containsString:searchText] || [city.pinYin.uppercaseString containsString:searchText.uppercaseString ] || [city.pinYinHead.uppercaseString containsString:searchText.uppercaseString]) {
//            [self.resultCites addObject:city];
//        }
//    }
    
    //预言，谓词：能更具一定的条件，从一个数组中过滤出想要的数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@",searchText,searchText,searchText];
    self.resultCites = [self.cities filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultCites.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1,创建cell
    static NSString *ID = @"cites";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
    }
    //2,设置cell的数据
    TFCity *city = self.resultCites[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%lu个搜索结果",(unsigned long)self.resultCites.count];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFCity *city = self.resultCites[indexPath.row];
    [TFNotificationCenter postNotificationName:TFCityDidSelectNotification object:nil userInfo:@{TFSelectCityName : city.name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
