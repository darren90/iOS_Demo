//
//  ViscosityLayout.m
//  自定义UICollectionView的布局
//
//  Created by Tengfei on 16/1/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "ViscosityLayout.h"
static const CGFloat ItemHW = 90;
static const CGFloat ItemMaigin = 20;

@implementation ViscosityLayout

-(instancetype)init
{
    if (self = [super init]) {
        //        UICollectionViewLayoutAttributes
        
    }
    return self;
}

/**
 *  一些初始化工作，最好在这里实现
 */
-(void)prepareLayout
{
    [super prepareLayout];
    
    //初始化
    self.itemSize = CGSizeMake(ItemHW, ItemHW);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = ItemMaigin;
    CGFloat inset = ItemMaigin;//(self.collectionView.frame.size.width - ItemHW) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}


/**
 *  控制最后srollview的最后去哪里
 *  用来设置collectionView停止滚动那一刻的位置
 *
 *  @param proposedContentOffset 原本Scrollview停止滚动那一刻的位置
 *  @param velocity              滚动速度
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //1.计算scrollview最后停留的范围
    CGRect lastRect ;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    //2.取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    //计算屏幕最中间的x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2 ;
    
    //3.遍历所有的属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
//        NSLog(@"-frame--:%@",NSStringFromCGRect(attrs.frame));
//        if(ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)){//取出最小值
//            adjustOffsetX = attrs.center.x - centerX;
//        }
        
//        attrs.frame.origin.x
    
        continue ;
    }
    
    
    //    CGPoint point = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}

/**
 *  返回yes，只要显示的边界发生改变，就需要重新布局：(会自动调用layoutAttributesForElementsInRect方法，获得所有cell的布局属性)
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  返回代表collectionView详细UICollectionViewLayoutAttributes信息的数组
 */
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    //0:计算可见的矩形框
//    CGRect visiableRect;
//    visiableRect.size = self.collectionView.frame.size;
//    visiableRect.origin = self.collectionView.contentOffset;
//    
//    //    UICollectionViewLayoutAttributes
//    //1.取出默认cell的UICollectionViewLayoutAttributes
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    
//    //计算屏幕最中间的x
//    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width / 2 ;
//    
//    //2.遍历所有的布局属性
//    for (UICollectionViewLayoutAttributes *attrs in array) {
//        //不是可见范围的 就返回，不再屏幕就直接跳过
//        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) continue;
//        
//        //每一个item的中心x值
//        CGFloat itemCenterx = attrs.center.x;
//        //差距越小，缩放比例越大
//        //根据与屏幕最中间的距离计算缩放比例
//        CGFloat scale = 1 + (1 - ABS(itemCenterx - centerX) / self.collectionView.frame.size.width * 0.6)*0.8;//比例值很随意，适合就好
//        NSLog(@"--scale:%f",scale);
//        
//        //用这个，缩放不会改变frame大小，所以判断可见范围就无效，item即将离开可见范围的时候，突然消失不见
//        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
//    }
//    
//    return array;
//}

@end
