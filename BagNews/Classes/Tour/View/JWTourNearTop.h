//
//  JWTourNearTop.h
//  BagNews
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWTourNearTop : UIScrollView
- (instancetype)initWithFrame:(CGRect)frame Arr:(NSArray *)array
;
@property(retain,nonatomic)UILabel *item;

@property(copy,nonatomic)void(^itemClick)(NSInteger index);

@property(assign,nonatomic)NSInteger index;
@end
