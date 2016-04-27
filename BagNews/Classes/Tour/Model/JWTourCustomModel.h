//
//  JWTourCustomModel.h
//  BagNews
//
//  Created by 微凉 on 16/4/27.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWModel.h"

@interface JWTourCustomModel : JWModel
@property(copy,nonatomic)NSString *cover_image;// 封面

@property(retain,nonatomic)NSDictionary *user;

@property(copy,nonatomic)NSString *popular_place_str;// 地点

@property(copy,nonatomic)NSString *name;// 标题

@property(copy,nonatomic)NSString *first_day;// 开始时间

@property(assign,nonatomic)NSInteger day_count;// 持续天数

@property(copy,nonatomic)NSString *share_url;// 详情链接

@property(copy,nonatomic)NSString *image_url;// 轮播图图片地址

@property(copy,nonatomic)NSString *html_url;// 图片详情地址

@end
