//
//  JWTourNearTop.m
//  BagNews
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourNearTop.h"

@interface JWTourNearTop ()

@property(copy,nonatomic)NSMutableArray *frames;
@property(copy,nonatomic)NSArray *items;

@end
@implementation JWTourNearTop
- (instancetype)initWithFrame:(CGRect)frame Arr:(NSArray *)array
{
    self.items = array;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self setUpBase];
        
    }
    
    return self;
}

- (void)setUpBase
{
    CGSize size = CGSizeZero;
    for (int i = 0; i < self.items.count; i++) {
        NSString *str = [self.items objectAtIndex:i];
        self.item = [[UILabel alloc] init];
        self.item.text = str;
        self.item.font = [UIFont boldSystemFontOfSize:18];
        self.item.layer.cornerRadius = 5 ;
        self.item.clipsToBounds = YES;
        self.item.tag = 1000 + i;
        self.item.userInteractionEnabled = YES;
        [self.item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColorAndContentOffset:)]];
        size  = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 ]}];
        if (self.frames.count == 0) {
            
            self.item.frame = CGRectMake(20, 2, size.width, 26);
            self.item.backgroundColor = [UIColor orangeColor];
            self.item.textColor = [UIColor whiteColor];
            [self.frames addObject:self.item];
            [self addSubview:self.item];
        }else{
            UILabel *lable = [self.frames lastObject];
            self.item.frame = CGRectMake(20 + lable.frame.size.width+lable.origin.x, 2, size.width, 26);
            [self addSubview:self.item];
            [self.frames addObject:self.item];
            
        }
    }
    
    UILabel *lable = [self.frames lastObject];
    
    self.contentSize = CGSizeMake(lable.x + 20 + lable.width, self.frame.size.height);
}

- (NSMutableArray *)frames
{
    if (!_frames) {
        _frames = [NSMutableArray array];
    }
    
    return _frames;
}
- (NSArray *)items
{
    if (!_items) {
        _items = [NSArray array];
    }
    
    return _items;
}
- (void)changeColorAndContentOffset:(UITapGestureRecognizer *)tap
{
    self.itemClick(tap.view.tag - 1000);
    for (UILabel *lable in self.frames) {
        if (lable.tag == tap.view.tag) {
            lable.backgroundColor = [UIColor orangeColor];
            lable.textColor = [UIColor whiteColor];
        } else
        {
            lable.backgroundColor = [UIColor whiteColor];
            lable.textColor = [UIColor blackColor];
        }
    }
    
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    for (UILabel *lable in self.frames) {
        if (lable.tag - 1000 == index) {
            lable.backgroundColor = [UIColor orangeColor];
            lable.textColor = [UIColor whiteColor];
        } else
        {
            lable.backgroundColor = [UIColor whiteColor];
            lable.textColor = [UIColor blackColor];
        }
    }

}
@end
