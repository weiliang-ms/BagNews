//
//  JWTitleView.m
//  BagNews
//
//  Created by 微凉 on 16/4/23.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTitleView.h"
#import "JWItem.h"
#define ITEMW SCREENWIDTH / 5
@interface JWTitleView ()

@property(nonatomic,retain)NSMutableArray *itemsArr;
@end
@implementation JWTitleView
- (NSMutableArray *)itemsArr
{
    if (!_itemsArr) {

        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        初始化一些属性
        self.bounces = NO;

//        self.directionalLockEnabled = YES;
        self.showsHorizontalScrollIndicator =  NO;
        self.showsVerticalScrollIndicator =  NO;
        self.delegate = self;
        
    }
    
    return self;
}
/*重写set*/
- (void)setDefaultArr:(NSArray *)defaultArr
{
    _defaultArr = defaultArr;
    self.contentSize = CGSizeMake(ITEMW * _defaultArr.count, 0);
    self.alwaysBounceVertical = NO;
    for (int i = 0; i < _defaultArr.count; i++) {
        JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(i * ITEMW, 5, ITEMW, 20)];
        [self addSubview:item];
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(responseTheTouchAction:)]];
        NSDictionary *dic = _defaultArr[i];
        [self.itemsArr addObject:item];
        item.text = dic[@"title"];
        item.tag =  1000 + i;
        if (item.tag == 1000) {
            item.textColor = [UIColor redColor];
            item.transform = CGAffineTransformMakeScale(1.2, 1.2);

        }
    }
//
}

- (void)responseTheTouchAction:(UITapGestureRecognizer *)tap
{
#pragma mark - 快速遍历取出数组里所有item进行重新赋值
    JWItem *item = (JWItem *)tap.view;
    for (JWItem *temp in self.itemsArr) {
        temp.textColor = [UIColor blackColor];
        temp.transform = CGAffineTransformMakeScale(1, 1);
    }

    item.textColor = [UIColor redColor];
    item.transform = CGAffineTransformMakeScale(1.5, 1.5);
    NSInteger index = tap.view.tag - 1000;
    // 大于某个下标 点的item保证在中间
    if (index > 2) {
        self.contentOffset = CGPointMake((index - 2) * ITEMW , 0);
    }
#pragma - mark 点击发送通知主VC偏移主Scr
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",index] forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mainScrContentOffset" object:nil userInfo:dic];
}
/*重写setter方法 实现上随下动*/
- (void)setCurrentItem:(NSInteger)currentItem
{
    _currentItem = currentItem;
    JWItem *item = [self.itemsArr objectAtIndex:currentItem ];
    for (JWItem *temp in self.itemsArr) {
        temp.textColor = [UIColor blackColor];
        temp.transform = CGAffineTransformMakeScale(1, 1);
    }
    
    // 大于某个下标 点的item保证在中间 -> 下拉列表代理传入
    if (currentItem > 2) {
        self.contentOffset = CGPointMake((currentItem - 2) * ITEMW , 0);
    }
    
    item.textColor = [UIColor redColor];
    item.transform = CGAffineTransformMakeScale(1.5, 1.5);
 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}
@end
