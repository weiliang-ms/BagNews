//
//  JWDanmuModel.h
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "CFDanmuClass.h"

@interface JWDanmuModel : CFDanmuClass
@property (nonatomic, strong) NSNumber* sendTime;
@property (nonatomic, strong) NSNumber* style;
@property (nonatomic, strong) NSNumber* fontSize;
@property (nonatomic, strong) NSNumber* textColor;
@property (nonatomic, strong) NSString* text;

+ (instancetype)modelWithParameter:(NSString*)parameter text:(NSString*)text;
@end
