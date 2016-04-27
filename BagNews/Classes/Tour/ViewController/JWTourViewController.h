//
//  JWTourViewController.h
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWBaseViewController.h"
@class JWCarouselFigureView;
@interface JWTourViewController : UITableViewController
@property(copy,nonatomic)NSArray *locations;

@property(copy,nonatomic)NSArray *models;

@property(nonatomic,strong)JWCarouselFigureView *carouseView;

@property (nonatomic, copy) NSString *next_start;


@end
