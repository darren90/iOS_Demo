//
//  LineLayout.m
//  自定义UICollectionView的布局
//
//  Created by Tengfei on 15/12/27.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "LineLayout.h"

static const CGFloat ItemHW = 100;

@implementation LineLayout

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
    self.minimumLineSpacing = 100;
    CGFloat inset = (self.collectionView.frame.size.width - ItemHW) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);

}

/**
 *  返回yes，只要显示的边界发生改变，就需要重新布局：(会自动调用layoutAttributesForElementsInRect方法，获得所有cell的布局属性)
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    UICollectionViewLayoutAttributes
    //1.取出默认cell的UICollectionViewLayoutAttributes
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕最中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width / 2 ;
    
    
    //2.遍历所有的布局属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        //每一个item的中心x值
        CGFloat itemCenterx = attrs.center.x;
        //差距越小，缩放比例越大
        //根据与屏幕最中间的距离计算缩放比例
       CGFloat scale = 1 + (1 - ABS(itemCenterx - centerX) / self.collectionView.frame.size.width * 0.5)*0.8;//比例值很随意，适合就好
        
        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
    }
    
    return array;
}

//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    return nil;
//}

@end
