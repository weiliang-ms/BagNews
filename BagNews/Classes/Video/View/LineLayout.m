//
//  LineLayout.m
//  SinaWeibo
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 ZT. All rights reserved.
//

#import "LineLayout.h"

@implementation LineLayout
-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
// 为布局做准备
-(void)prepareLayout
{
    // 进行一些初始化的设置
    self.itemSize = CGSizeMake(150, 150);
    self.minimumLineSpacing = 100;
    self.minimumInteritemSpacing = 50;
    CGFloat inset = (self.collectionView.frame.size.width-100) / 2;
    
    self.sectionInset = UIEdgeInsetsMake(5, inset, 5, inset);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 每个item(cell)都有自己的UICollectionViewLayoutAttributes属性
    // 每个indexPath 都有自己的UICollectionViewLayoutAttributes属性
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

//
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 拿到装有父类所有属性的数组
    NSArray *atts = [super layoutAttributesForElementsInRect:rect];
    NSArray *attrArr = [[NSArray alloc] initWithArray:atts copyItems:YES];
    CGFloat centerX = self.collectionView.frame.size.width*0.5 + self.collectionView.contentOffset.x;
    
    // 可见范围内进行等比例缩放
    CGRect visRect;
    visRect.size = self.collectionView.frame.size;
    visRect.origin = self.collectionView.contentOffset;
    
    for (UICollectionViewLayoutAttributes *temp in attrArr) {
//        NSLog(@"begin")
        // 判断可见矩形 与item对象矩形是否相交
        if (!CGRectIntersectsRect(visRect, temp.frame))
            continue;
        CGFloat scale = 1+(1-ABS(temp.center.x - centerX) / 200);
        temp.transform3D = CATransform3DMakeScale(scale, scale, 0);
//        NSLog(@"end");
    }
    return attrArr;
}
@end
