//
//  JWDaramHeadModel.h
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWRunTimeModel.h"

@interface JWDaramHeadModel : JWRunTimeModel

@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *descriptions;
@property(copy,nonatomic)NSString *aid;
//@property(copy,nonatomic)NSString *typeid;
@property(assign,nonatomic)NSInteger play;
@property(assign,nonatomic)NSInteger video_review;
@property(copy,nonatomic)NSString *author;
@property(copy,nonatomic)NSString *typeName;
@property(copy,nonatomic)NSString *subtitle;
@property(copy,nonatomic)NSString *review;
@property(copy,nonatomic)NSString *favorites;
@property(copy,nonatomic)NSString *create;
@property(copy,nonatomic)NSString *diration;
@end
