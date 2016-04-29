//
//  TFMarqueeView.m
//  MarqueeUPDown
//
//  Created by Fengtf on 16/4/28.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "TFMarqueeView.h"
#import "TFMarqueeCell.h"
#import "TFMarqueeModel.h"

@interface TFMarqueeView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSArray * dataArray;
/** UICollectionView */
@property (nonatomic,weak)UICollectionView * TFCollectionView;
/** UICollectionView的布局 */
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
/**UIPageControl */
@property (nonatomic,weak)UIPageControl * pageControl;
/**NSTimer对象 */
@property (nonatomic,strong)NSTimer * timer;

@end

@implementation TFMarqueeView
static NSString *const identifier = @"tfcycle";
/**UICollectionView的分组数 */
static int const TFSection = 100;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

-(void)initialization
{
    //init UICollectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    UICollectionView *TFCollectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flowLayout];
    self.TFCollectionView = TFCollectionView;
    [self addSubview:TFCollectionView];
    TFCollectionView.backgroundColor = [UIColor whiteColor];
    TFCollectionView.delegate = self;
    TFCollectionView.dataSource = self;
    self.flowLayout = flowLayout;
    TFCollectionView.pagingEnabled = YES;
//    TFCollectionView.scrolldi
    TFCollectionView.showsHorizontalScrollIndicator = NO;
    TFCollectionView.showsVerticalScrollIndicator = NO;
    
    [self.TFCollectionView registerClass:[TFMarqueeCell class] forCellWithReuseIdentifier:identifier];
    
    //init pagecontrol
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
//    [self addSubview:pageControl];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.TFCollectionView.frame = self.bounds;
    
    //设置布局
    self.flowLayout.itemSize = self.frame.size; //CGSizeMake(self.frame.size.width, imgH);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//UICollectionViewScrollDirectionHorizontal;
    
    [self.TFCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:TFSection / 2] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    
    [self addTimer];
    
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    self.pageControl.numberOfPages = self.dataArray.count;
    CGSize page1Size = [self.pageControl sizeForNumberOfPages:1];
    CGFloat pageW = self.dataArray.count * page1Size.width;
    CGFloat pageH = 20;
    CGFloat viewH = self.frame.size.height;
    CGFloat viewW = self.frame.size.width;
    self.pageControl.frame = CGRectMake(viewW - pageW - 25, viewH - pageH - 6, pageW, pageH);
}

#pragma - mark UICollectionView代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return TFSection;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFMarqueeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    cell.placeholderImage = self.placeholderImage;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(marqueeViewDidSelectAtIndex:)]) {
        [self.delegate marqueeViewDidSelectAtIndex:indexPath.item];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int pageNum = (int)((scrollView.contentOffset.x / self.frame.size.width) + 0.5) % self.dataArray.count;
    self.pageControl.currentPage = pageNum;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self destroyTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

-(void)setImgsArray:(NSArray *)imgsArray
{
    _imgsArray = imgsArray;
    if (imgsArray.count == 0) return;
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < imgsArray.count; i++) {
        TFMarqueeModel *model = [[TFMarqueeModel alloc]init];
//        model.imgUrl = imgsArray[i];
        model.tittle = imgsArray[i];
        [images addObject:model];
    }
    self.dataArray = images;
    [self.TFCollectionView reloadData];
}

#pragma mark - 增加定时器
-(void)addTimer
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(goToNext) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        //消息循环，添加到主线程
        //extern NSString* const NSDefaultRunLoopMode;  //默认没有优先级
        //extern NSString* const NSRunLoopCommonModes;  //提高优先级
    }
}
#pragma mark - 销毁定时器
-(void)destroyTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.TFCollectionView indexPathsForVisibleItems] lastObject];
    NSLog(@"-VisibleItems:%ld---",currentIndexPath.item);

    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:TFSection/2];
    [self.TFCollectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    return currentIndexPathReset;
}

-(void)goToNext
{
    if (!self.timer)  return; //计时器清空了，这个方法还是会调用？？
    NSIndexPath *currentIndexPath = [self resetIndexPath];

    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    NSLog(@"-:%ld-:%ld---:%ld",currentIndexPath.item,(long)nextItem,(long)nextSection);
    if (nextItem == self.dataArray.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.TFCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
//    self.TFCollectionView selectItemAtIndexPath:<#(nullable NSIndexPath *)#> animated:<#(BOOL)#> scrollPosition:<#(UICollectionViewScrollPosition)#>
    
    self.pageControl.currentPage = nextItem;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
@end