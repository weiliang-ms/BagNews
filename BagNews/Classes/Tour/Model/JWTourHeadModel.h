//
//  JWTourHeadModel.h
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWModel.h"

@interface JWTourHeadModel : JWModel
@property(copy,nonatomic)NSString *platform;
@property(copy,nonatomic)NSString *image_url;
@property(copy,nonatomic)NSString *html_url;
@property(copy,nonatomic)NSString *title;

@end
