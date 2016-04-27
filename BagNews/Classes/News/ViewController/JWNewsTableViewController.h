//
//  JWNewsTableViewController.h
//  BagNews
//
//  Created by 微凉 on 16/4/23.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTableViewControllerClass.h"
@class JWCarouselFigureView;
@interface JWNewsTableViewController : JWTableViewControllerClass
@property(copy,nonatomic)NSString *url;
@property(copy,nonatomic)NSString *more;
@property(copy,nonatomic)NSMutableArray *dataArr;
@property(nonatomic,strong)JWCarouselFigureView *carouseView;

@end
