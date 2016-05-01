//
//  JWDramaBar.h
//  BagNews
//
//  Created by 微凉 on 16/5/1.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWDramaBar : UIView

@property(assign,nonatomic)NSInteger itemW;
@property(copy,nonatomic)void(^clickBtn)(NSInteger index);

@property(retain,nonatomic)UILabel *scrLable;

- (void)changeColor:(NSInteger)index;
@end
