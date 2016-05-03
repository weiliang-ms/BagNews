//
//  JWSpModel.h
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWRunTimeModel.h"

@interface JWSpModel : JWRunTimeModel
@property (nonatomic,copy) NSString *evaluate;
@property (nonatomic,strong) NSArray *episodes;
@property (nonatomic,strong) NSArray *tags;
@property (nonatomic,strong) NSArray *seasons;
@end
