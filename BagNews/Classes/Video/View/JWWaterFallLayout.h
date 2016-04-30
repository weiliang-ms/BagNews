//
//  JWWaterFallLayout.h
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWWaterFallLayout.h"
@class JWWaterFallLayout;
@protocol JWShopFlowLayoutDelegate <NSObject>
@optional
- (CGFloat)shopFlowLayoutWithHight:(JWWaterFallLayout *)flowLayout layoutWitdh:(CGFloat)cellW forIndex:(NSIndexPath *)indexP;

@end
@interface JWWaterFallLayout : UICollectionViewFlowLayout
@property (nonatomic,weak) id<JWShopFlowLayoutDelegate> delegate;
@property (nonatomic,assign) NSInteger colNum;// 瀑布流列数
@end
