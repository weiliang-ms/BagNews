//
//  JWDanmuModel.m
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDanmuModel.h"

@implementation JWDanmuModel
+ (instancetype)modelWithParameter:(NSString*)parameter text:(NSString*)text{
    NSArray* strArr = [parameter componentsSeparatedByString:@","];
    JWDanmuModel* model = [[JWDanmuModel alloc] init];
    model.sendTime = @([strArr[0] doubleValue]);
    model.style = @([strArr[1] intValue]);
    model.fontSize = @([strArr[2] floatValue]/1.5);
    model.textColor = @([strArr[3] doubleValue]);
    model.text = text;
    return model;
}
@end
