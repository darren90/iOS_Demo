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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,weak)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initTableView];
}

-(void)initTableView
{
    UITableView * tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
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
    cell.frameModel = self.dataArray[indexPath.row];
    
    return cell;
}


-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        NSArray *array  = @[@"The first step to creating a fancy animation was creating a UITableViewCell (called BookCell) with flexible constraints. By flexible, I mean that no constraint was absolutely required. The cell included a yellow subview subview with a collapsible height constraint — the height constraint always has a constant of 0, and it initially has a priority of 999. Within the collapsible subview, no vertical constraints are required. We set the priority of all the internal vertical constraints to 998.",@"用人单位法定节假日安排加班，应按不低于日或者小时工资基数的300％支付加班工资，休息日期间安排加班，应当安排同等时间补休，不能安排补休的，按照不低于日或者小时工资基数的200％支付加班工资。",@"如《广东省工资支付条例》第三十五 条非因劳动者原因造成用人单位停工、停产，未超过一个工资支付周期（最长三十日）的，用人单位应当按照正常工作时间支付工资。超过一个工资支付周期的，可以根据劳动者提供的劳动，按照双方新约定的标准支付工资；用人单位没有安排劳动者工作的，应当按照不低于当地最低工资标准的百分之八十支付劳动者生活费，生活费发放至企业复工、复产或者解除劳动关系。",@"来看看劳动法克林顿刷卡思考对方卡拉卡斯的楼房卡拉卡斯的疯狂拉萨的罚款 ",@"中秋节、十一假期分为两类。一类是法定节假日，即9月30日(中秋节)、10月1日、2日、3日共四天为法定节假日;另一类是休息日，即10月4日至10月7日为休息日。",@"2000(元)÷21.75(天)×200％×1(天)=183.9(元)"];
        
        for (NSString *str in array) {
            UnfoldModel *model = [[UnfoldModel alloc]init];
            model.contenxt = str;
            
            UnfoldFrameModel *frameModel = [[UnfoldFrameModel alloc]init];
            frameModel.model = model;
            [_dataArray addObject:frameModel];
        }
    }
    return _dataArray;
}

 

@end
