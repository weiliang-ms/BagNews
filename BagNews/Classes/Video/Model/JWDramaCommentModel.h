//
//  JWDramaCommentModel.h
//  BagNews
//
//  Created by 微凉 on 16/5/3.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWRunTimeModel.h"

@interface JWDramaCommentModel : JWRunTimeModel

@property (nonatomic, copy) NSString *face;

@property (nonatomic, assign) NSInteger mid;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, assign) NSInteger ad_check;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *reply;

@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, assign) NSInteger lv;

@property (nonatomic, assign) NSInteger good;

@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, copy) NSString *fbid;

@property (nonatomic, assign) NSInteger create;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *device;

@property (nonatomic, assign) NSInteger reply_count;

@end

