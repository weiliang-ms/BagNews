//
//  JWCarouselFigureView.h
//  JWCarouselFigureView
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWCarouselFigureView : UIView
/*图片数组*/
@property(copy,nonatomic)NSArray *pics;
/*标题数组*/
@property(copy,nonatomic)NSArray *titles;
/*轮播时间间隔*/
@property(assign,nonatomic)NSInteger sec;
/*拖拽结束重新开启定时器间隔*/
@property(assign,nonatomic)NSInteger secNew;
/*点击回传*/
@property(copy,nonatomic)void(^CallBack)(NSInteger index);
/*页数颜色*/
@property(retain,nonatomic)UIColor *color;

@end
