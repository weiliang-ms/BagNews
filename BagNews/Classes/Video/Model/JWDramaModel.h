//
//  JWDramaModel.h
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWRunTimeModel.h"

@interface JWDramaModel : JWRunTimeModel
@property(copy,nonatomic)NSString *cover;

@property(copy,nonatomic)NSString *title;
@property (nonatomic,assign) NSInteger play_count;
@property (nonatomic,assign) NSInteger danmaku_count;
@property (nonatomic,assign) NSInteger season_id;
@property (nonatomic,assign) NSInteger weekday;
@property (nonatomic,copy) NSString *bgmcount;
@property (nonatomic,assign) NSInteger is_finish;
@property (nonatomic,assign) Boolean isNew;


@end
