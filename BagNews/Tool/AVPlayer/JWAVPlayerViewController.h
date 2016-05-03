//
//  JWAVPlayerViewController.h
//  BagNews
//
//  Created by 微凉 on 16/5/1.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWAVPlayerViewController : UIViewController

@property(copy,nonatomic)NSString *url; // 视频网址

@property (nonatomic, copy) NSString* danmaku;

@property(copy,nonatomic)void(^playFinished)();

@end
