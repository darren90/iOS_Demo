//
//  ViewController.m
//  UITableViewCell的展开与收缩
//
//  Created by Fengtf on 15/12/28.
//  Copyright © 2015年 ftf. All rights reserved.
//

#import "ViewController.h"
#import "UnfoldFrameModel.h"
#import "UnfoldModel.h"
#import "UnfoldCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UnfoldCellDelegate>
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,weak)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initLoadData];
    
    [self initTableView];
}



-(void)initLoadData
{
    self.dataArray = [NSMutableArray array];
    NSArray *array  = @[@"Apple is supplying this information to help you plan for the adoption of the technologies and programming interfaces described herein for use on Apple-branded products. This information is subject to change, and software implemented according to this document should be tested with final operating system software and final documentation. Newer versions of this document may be provided with future betas of the API or technology.",@"维基百科（Wikipedia），是一个基于维基技术的多语言百科全书协作计划，这是一部用多种语言编写的网络百科全书。  维基百科一词取自于该网站核心技术“Wiki”以及具有百科全书之意的共同创造出来的新混成词“Wikipedia”，维基百科是由非营利组织维基媒体基金会负责营运，并接受捐赠。",@"2002年2月，由Edgar Enyedy领导，非常活跃的西班牙语维基百科突然退出维基百科并建立了他们自己的自由百科（Enciclopedia Libre）；理由是未来可能会有商业广告及失去主要的控制权。",@"来看看劳动法克林顿刷卡思考对方卡拉卡斯的楼房卡拉卡斯的疯狂拉萨的罚款 ",@"2015年11月1日，英文维基百科条目数突破500万",@"2015年6月15日，维基百科全面采用HTTPS：保护用户敏感信息。"];
    
    for (NSString *str in array) {
        UnfoldModel *model = [[UnfoldModel alloc]init];
        model.contenxt = str;
        model.isUnflod = NO;//给出初始值
        
        UnfoldFrameModel *frameModel = [[UnfoldFrameModel alloc]init];
        frameModel.model = model;
        [self.dataArray addObject:frameModel];
    }

}

-(void)initTableView
{
    UITableView * tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1,创建cell
    static NSString *ID = @"cell";
    UnfoldCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UnfoldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
    }
    //2,设置cell的数据
    UnfoldFrameModel *frameModel = self.dataArray[indexPath.row];
    cell.frameModel = frameModel;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnfoldFrameModel *frameModel = self.dataArray[indexPath.row];
    return frameModel.cellH;
}


-(void)UnfoldCellDidClickUnfoldBtn:(UnfoldFrameModel *)frameModel
{
    NSInteger index = [self.dataArray indexOfObject:frameModel];
    UnfoldModel *model = frameModel.model;
    model.isUnflod = !model.isUnflod;
    frameModel.model = model;//这句话很关键，要把值设置回来，因为其setModel方法中会重新计算frame
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
 
//-(NSMutableArray *)dataArray
//{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
//        
//        }
//    return _dataArray;
//}
//
// 

@end
