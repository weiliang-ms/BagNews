//
//  JWListView.h
//  BagNews
//
//  Created by 微凉 on 16/4/23.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWBar.h"

@protocol JWListViewDelegate <NSObject>

- (void)itemTapClick:(NSInteger)index;

@end
@interface JWListView : UIView
@property(copy,nonatomic)NSMutableArray *topArr;
@property(copy,nonatomic)NSMutableArray *bottomArr;
@property(nonatomic,strong)JWBar *bar;
@property(copy,nonatomic)void(^TapBlock)(NSInteger index);
@property(nonatomic,copy)NSMutableArray *itemsArr;
@property(assign,nonatomic)id<JWListViewDelegate>delegate;

@end
