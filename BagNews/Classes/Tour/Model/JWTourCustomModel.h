//
//  JWTourCustomModel.h
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWModel.h"

@interface JWTourCustomModel : JWModel
@property(copy,nonatomic)NSString *cover_image_default ;
@property(copy,nonatomic)NSString *last_day;
@property(copy,nonatomic)NSString *day_count;
@property(copy,nonatomic)NSString *view_count;
@property(copy,nonatomic)NSDictionary *user;
@property(copy,nonatomic)NSString *popular_place_str ;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *is_featured_trip;


@end
