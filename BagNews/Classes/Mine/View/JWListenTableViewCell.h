//
//  JWListenTableViewCell.h
//  BagNews
//
//  Created by 微凉 on 16/6/14.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JWListenModel;
//#import "JYSCityNewsModel.h"
@interface JWListenTableViewCell : UITableViewCell
@property(nonatomic,strong)JWListenModel *model;

@property(nonatomic,retain)UILabel *fileSizeLable;

@property(nonatomic,retain)UILabel *timeLable;

@property(nonatomic,retain)UIImageView *titleImage;

@property(nonatomic,retain)UILabel *titleLable;

@property(nonatomic,retain)UILabel *digestLable;

@end
