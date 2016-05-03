//
//  CFDanmuku.h
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "CFDanmuClass.h"
typedef NS_ENUM(NSUInteger,JWDanmukuPosition){
    JWDanmakuPositionNone = 0,
    JWDanmakuPositionCenterTop,
    JWDanmakuPositionCenterBottom
};
@interface CFDanmuku : CFDanmuClass
// 对应视频的时间戳
@property(nonatomic, assign) NSTimeInterval timePoint;
// 弹幕内容
@property(nonatomic, copy) NSAttributedString* contentStr;
// 弹幕类型(如果不设置 默认情况下只是从右到左滚动)
@property(nonatomic, assign) JWDanmukuPosition position;

@end
