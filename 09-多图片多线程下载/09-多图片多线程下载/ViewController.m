//
//  ViewController.m
//  09-多图片多线程下载
//
//  Created by Tengfei on 2017/4/15.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import "ViewController.h"
#import "ImageModel.h"
#import "ImageCell.h"

@interface ViewController ()


@property (nonatomic,strong)NSArray * datas;

/** 内存中图片的缓存字典 */
@property (nonatomic,strong)NSMutableDictionary * memoryImages;

/** 操作队列 - 下载队列 */
@property (nonatomic,strong)NSOperationQueue *queue;

/** 下载操作的字典 */
@property (nonatomic,strong)NSMutableDictionary * operations;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 100;
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"--path:  %@",path);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1,创建cell
    static NSString *ID = @"cell";
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
 
    //2,设置cell的数据
    
    ImageModel *model = self.datas[indexPath.row];
    
    NSString *url = model.url;
    
    cell.titleL.text = model.name;
    [self downImageAction:indexPath cell:cell url:url];
    
    return cell;
}


-(void)downImageAction:(NSIndexPath *)indexPath cell:(ImageCell *)cell url:(NSString *)url{
    
    //内存缓存中去图片
    NSData *imageData = [self.memoryImages objectForKey:url];
    
    if (imageData) {
        NSLog(@"-内存-取图片-: %ld",(long)indexPath.row);
        UIImage *image = [UIImage imageWithData:imageData];
        cell.iconView.image = image;

    }else{
        NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        //获取图片名字,图片名称不能包含URL，
        NSString *fileName = [url lastPathComponent];
        NSString *filePaPath  = [path stringByAppendingPathComponent:fileName];

        //内存中没有图片的缓存 -- 从沙盒中取出
        NSData *imageData = [NSData dataWithContentsOfFile:filePaPath];
        
        if (imageData) {
            NSLog(@"-沙盒-取图片-: %ld",(long)indexPath.row);
            UIImage *image = [UIImage imageWithData:imageData];
            cell.iconView.image = image;
            
            //沙盒中取出后，放一份到内存缓存中
            [self.memoryImages setObject:imageData forKey:url];
            
        }else{
            //图片内存没有 ， 沙盒缓存中也没有，去下载
            
            NSBlockOperation *doo = [self.operations objectForKey:url];
            if (doo == nil) {
                NSLog(@"-下载-图片-: %ld",(long)indexPath.row);
                
                //显示占位图
                cell.iconView.image = [UIImage imageNamed:@"123"];
                
                NSBlockOperation *downO = [NSBlockOperation blockOperationWithBlock:^{
                    NSURL *uurl = [NSURL URLWithString:url];
                    
                    NSURLSession *session = [NSURLSession sharedSession];
                    NSURLSessionDataTask *down = [session  dataTaskWithURL:uurl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        
                        if (error == nil) {
                            if (data == nil) {
                                [self.operations removeObjectForKey:url];
                                return ;
                            }
                            
                            //把图片data存入内存中
                            [self.memoryImages setObject:data forKey:url];
                            
                            //同时写入沙盒中，永久缓存
                            [data writeToFile:filePaPath atomically:YES];
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                
                                UIImage *image = [UIImage imageWithData:data];
                                cell.iconView.image = image;
                                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                            }];
                            
                            //下载队列中移除已经完成的任务
                            [self.operations removeObjectForKey:url];
                            
                        }
                    }];
                    
                    [down resume];
                }];
                
                //下载对象加入队列中
                [self.operations setObject:downO forKey:url];
                [self.queue addOperation:downO];
            }
        }
    
    }

   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
    //清空队列中所有的任务
    [self.queue cancelAllOperations];
    
    //清空内存缓存
    [self.memoryImages removeAllObjects];
}


-(NSMutableDictionary *)memoryImages{
    if (_memoryImages == nil) {
        _memoryImages = [NSMutableDictionary dictionary];
    }
    return _memoryImages;
}

-(NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

-(NSMutableDictionary *)operations{
    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}


-(NSArray *)datas{
    if (_datas == nil ) {
        NSDictionary *d1 = @{@"name" : @" 我用整个夏天迎接你--首尔" , @"url" : @"http://p2.so.qhimgs1.com/sdr/1350_900_/t01d8f3a130704bb822.jpg"};
        NSDictionary *d2 = @{@"name" : @"寻找一份宁静 小清新美女野草集桌面壁纸" , @"url" : @"http://p2.so.qhimgs1.com/t01432f768fb6563272.jpg"};

        NSDictionary *d3 = @{@"name" : @"奥迪帅气难挡" , @"url" : @"http://p0.so.qhimgs1.com/sdr/597_900_/t01f1d8fdf87651e72c.jpg"};

        NSDictionary *d4 = @{@"name" : @"身在柬埔寨的6天跨年" , @"url" : @"http://p2.so.qhmsg.com/t011c4860a95a36bd17.jpg"};

        NSDictionary *d5 = @{@"name" : @"上海我来了" , @"url" : @"http://p3.so.qhimgs1.com/t01fc8f3f293b8c3c03.jpg"};

        NSDictionary *d6 = @{@"name" : @"青春是明媚的忧伤" , @"url" : @"http://p0.so.qhimgs1.com/t018327d3cd5773f7d0.jpg"};

        NSDictionary *d7 = @{@"name" : @"阳光的午后最温馨" , @"url" : @"http://p5.so.qhimgs1.com/t01f16644b9304bac9b.jpg"};

        NSDictionary *d8 = @{@"name" : @"优美图美女秀场诱惑妹子组图" , @"url" : @"http://p0.so.qhimgs1.com/t0159c8199b9a1f1630.jpg"};

        NSDictionary *d9 = @{@"name" : @"海边无邪纯净拉琴美女温馨迷人写真" , @"url" : @"http://p4.so.qhmsg.com/sdr/656_900_/t01c89b75bac2b84cc9.jpg"};

        NSDictionary *d10 = @{@"name" : @"夕雨印记的天" , @"url" : @"http://p1.so.qhimgs1.com/t01100cf3ca0a1c5161.jpg"};
        
        NSArray *dictArr = @[d1,d2,d3,d4,d5,d6,d7,d8,d9,d10];
        NSMutableArray *moldes = [NSMutableArray array];
        for (NSDictionary *dict in dictArr) {
            ImageModel *m = [ImageModel modelWithDict:dict];
            [moldes addObject:m];
        }
        
        _datas = moldes;
    }
    return _datas;
}



@end
