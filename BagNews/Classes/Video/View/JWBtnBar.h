//
//  JWBtnBar.h
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWBtnBar : UIView
@property (nonatomic, strong) NSArray* titleArr;
@property (nonatomic, copy) void (^clickBtn)(NSInteger);
@property (nonatomic, weak) UIView* bottomView;
- (void)changeBtnColor:(NSInteger)tagNum;
@end
