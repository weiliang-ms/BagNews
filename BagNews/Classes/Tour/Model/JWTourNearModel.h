//
//  JWTourNearModel.h
//  BagNews
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWModel.h"

@interface JWTourNearModel : JWModel
@property(copy,nonatomic)NSString *cover;
@property(copy,nonatomic)NSString *slug_url;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *descriptions;
@property(assign,nonatomic)double distance;
@property(assign,nonatomic)NSInteger visited_count;
@property(copy,nonatomic)NSString *address;

@end
