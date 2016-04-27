//
//  JWNewsModel.h
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWModel.h"

@interface JWNewsModel : JWModel

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *kpic;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, copy) NSString *feedShowStyle;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *bpic;

@property (nonatomic, assign) NSInteger pubDate;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) NSInteger articlePubDate;

@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, retain) NSDictionary *comment_count_info;

@property (nonatomic, copy) NSString *long_title;

@property (nonatomic, assign) BOOL is_focus;

@property (nonatomic, strong) NSDictionary *pics;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, assign) NSInteger comment_status;

@property (nonatomic, assign) NSInteger qreply;

@property (nonatomic, assign) NSInteger show;

@property (nonatomic, assign) NSInteger dispraise;

@property (nonatomic, assign) NSInteger praise;

@end

