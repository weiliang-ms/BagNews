//
//  JWDramaBar.m
//  BagNews
//
//  Created by 微凉 on 16/5/1.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaBar.h"

@interface JWDramaBar ()

@property(nonatomic,retain)UIButton *rightBtn;
@property(nonatomic,retain)UIButton *leftBtn;
@property(nonatomic,retain)UIButton *centerBtn;
@property(assign,nonatomic)NSInteger currentItem;

@property(copy,nonatomic)NSArray *arr;
@end
@implementation JWDramaBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        self.itemW = 90 * 3;
        self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*90, 0, 90, 43)];
        self.rightBtn.tag = 1003;
        [self addSubview:self.rightBtn];
        [self.rightBtn setTitle:@"评论相关" forState:0];
        
        self.leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 43)];
        [self addSubview:self.leftBtn];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:0];
        [self.leftBtn setTitle:@"番剧相关" forState:0];
        
        self.centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 0, 90, 43)];
        self.centerBtn.tag = 1002;
        [self addSubview:self.centerBtn];
        [self.centerBtn setTitle:@"相关视频" forState:0];
        [self.centerBtn setTitleColor:[UIColor blackColor] forState:0];
        [self.rightBtn setTitleColor:[UIColor blackColor] forState:0];
        self.scrLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, 90, 3)];
        self.scrLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrLable];

//        self.arr = @[self.leftBtn,self.rightBtn,self.centerBtn];
        [self.rightBtn addTarget:self action:@selector(changeColorAndScroll:) forControlEvents:1<<6];
           [self.leftBtn addTarget:self action:@selector(changeColorAndScroll:) forControlEvents:1<<6];
           [self.centerBtn addTarget:self action:@selector(changeColorAndScroll:) forControlEvents:1<<6];
        self.currentItem = 1;
        self.leftBtn.tag = 1001;

    }
    
    return self;
}

- (void)changeColorAndScroll:(UIButton *)sender
{
    [self changeColor:sender.tag - 1000];
    self.clickBtn(sender.tag - 1000);
}

- (void)changeColor:(NSInteger)index
{
//    NSLog(@"%ld",index);
    if (self.currentItem!=0) {
        [(UIButton *)[self viewWithTag:self.currentItem+1000] setTitleColor:[UIColor blackColor] forState:0];
        
    }
[(UIButton *)[self viewWithTag:index+1000] setTitleColor:[UIColor whiteColor] forState:0];
    self.currentItem = index;
}

@end
