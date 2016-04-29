//
//  JWTourNearModel.m
//  BagNews
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourNearModel.h"

@implementation JWTourNearModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        value = _descriptions;
    }
}
@end
