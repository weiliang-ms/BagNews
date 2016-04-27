//
//  JWTourDayly.h
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWModel.h"

@interface JWTourDayly : JWModel
@property(copy,nonatomic)NSString *text;
@property(copy,nonatomic)NSString *index_cover;
@property(copy,nonatomic)NSString *share_url;
@property(copy,nonatomic)NSDictionary *user;
@property(copy,nonatomic)NSDictionary *poi;

@end
