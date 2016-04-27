//
//  JWArrowBtn.m
//  BagNews
//
//  Created by 微凉 on 16/4/23.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWArrowBtn.h"

@implementation JWArrowBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"xiangxia"] forState:0];
        [self setBackgroundImage:[UIImage imageNamed:@"xiangxia"] forState:1<<0];
        [self addTarget:self action:@selector(clickEventAction) forControlEvents:1<<6];
    }
    
    return self;
}

- (void)clickEventAction
{
    if (self.ArrowBlock) {
        self.ArrowBlock();
    }
}
@end
