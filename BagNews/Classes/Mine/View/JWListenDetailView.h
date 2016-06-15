//
//  JWListenDetailView.h
//  BagNews
//
//  Created by 微凉 on 16/6/15.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JWListenDetailModel.h"

@interface JWListenDetailView : UIView


@property(nonatomic,retain)UILabel *titleLable;

@property(nonatomic,retain)UILabel *dateLable;

@property(nonatomic,retain)UILabel *excerptLable;

@property(nonatomic,retain)UIImageView *imageView;

@property(nonatomic,retain)UIScrollView *scrollView;

-(void)reloadData:(JWListenDetailModel*)model;

@end
