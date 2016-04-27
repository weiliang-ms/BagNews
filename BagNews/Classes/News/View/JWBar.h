//
//  JWBar.h
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWArrowBtn.h"
@interface JWBar : UIView

@property(nonatomic,strong)JWArrowBtn *arrowBtn;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *makeSure;
@property(copy,nonatomic)void(^BarAction)();

@end
