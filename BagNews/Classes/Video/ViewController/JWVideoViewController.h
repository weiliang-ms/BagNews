//
//  JWVideoViewController.h
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWDramaHeader.h"
@interface JWVideoViewController : UIViewController

@property(copy,nonatomic)NSArray *models;

@property(copy,nonatomic)NSArray *heads;

@property(copy,nonatomic)NSArray *centers;

@property(nonatomic,strong)JWDramaHeader *header;


@end
