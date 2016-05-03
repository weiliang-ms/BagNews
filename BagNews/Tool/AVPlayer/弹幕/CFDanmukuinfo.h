//
//  CFDanmukuinfo.h
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "CFDanmuClass.h"
@class CFDanmuku;
@interface CFDanmukuinfo : CFDanmuClass

// 弹幕内容label
@property(nonatomic, weak) UILabel  *playLabel;

@property(nonatomic, assign) NSTimeInterval leftTime;

@property(nonatomic, strong) CFDanmuku* danmaku;

@property(nonatomic, assign) NSInteger lineCount;

@end
