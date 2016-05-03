//
//  JWDramaDetailChild.h
//  BagNews
//
//  Created by 微凉 on 16/5/2.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWDaramHeadModel;
@interface JWDramaDetailChild : UIViewController

@property(nonatomic,strong)JWDaramHeadModel *model;

@property(copy,nonatomic)NSArray *comments;// 评论数据数组

@end
