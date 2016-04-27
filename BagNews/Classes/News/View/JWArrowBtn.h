//
//  JWArrowBtn.h
//  BagNews
//
//  Created by 微凉 on 16/4/23.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWArrowBtn : UIButton
@property(copy,nonatomic)void(^ArrowBlock)();
@end
