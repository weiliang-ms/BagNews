//
//  JWBar.m
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWBar.h"
#define W 20
@implementation JWBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(W, 5, 4 * W, W)];
        _label.text = @"  切换栏目";
        _label.textColor = [UIColor blackColor];
        [self addSubview:_label];
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.3;
        self.arrowBtn = [[JWArrowBtn alloc] initWithFrame:CGRectMake(SCREENWIDTH - 30, 5, W, W)];
        self.arrowBtn.backgroundColor = [UIColor redColor];
        
        [self addSubview:self.arrowBtn];
        self.makeSure = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 4 * W, 5, 2 * W, W)];
        [self addSubview:self.makeSure];
        [self.makeSure setTitle:@"确定" forState:0];
        [self.makeSure setTitle:@"确定" forState:1<<0];
        [self.makeSure setTitleColor:[UIColor redColor] forState:0];
         [self.makeSure setTitleColor:[UIColor redColor] forState:1<<0];
        
        [self.makeSure addTarget:self action:@selector(actionClick) forControlEvents:1<<6];
        self.makeSure.hidden = YES;
    }
    
    return self;
}
- (void)actionClick
{
    if (self.BarAction) {
        self.BarAction();
    }
}
@end
