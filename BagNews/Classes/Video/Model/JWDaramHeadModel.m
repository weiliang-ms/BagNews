//
//  JWDaramHeadModel.m
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDaramHeadModel.h"

@implementation JWDaramHeadModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        value = _descriptions;
    }
}


@end


