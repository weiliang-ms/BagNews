//
//  JWListView.m
//  BagNews
//
//  Created by 微凉 on 16/4/23.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWListView.h"
#import "JWItem.h"
#import "FMDBTool.h"
#import "JWNewsDB.h"
#define ITEMW (SCREENWIDTH - 50) / 4
@interface JWListView ()
@property(retain,nonatomic)UILabel *labelMessage;

@property(nonatomic,strong)UIScrollView *topScr;

@property(nonatomic,strong)UIScrollView *bottomScr;

@property(nonatomic,assign)BOOL selected;
@end
@implementation JWListView
// lazyLoading -> 装放所有Item
- (NSMutableArray *)itemsArr
{
    if (_itemsArr == nil) {
        _itemsArr = [NSMutableArray array];
    }
    
    return _itemsArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
                
        _bar = [[JWBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
        WEAK(ws);
        _bar.BarAction = ^()
        {
            
            __strong typeof(ws)strongSelf = ws;
            strongSelf.bar.makeSure.hidden = YES;
            strongSelf.bar.label.text = @"  切换栏目";

            for (JWItem *item in strongSelf.itemsArr) {
                    item.state = commonState;
                    item.deleteImg.hidden = YES;
            }

        };
        [self addSubview:_bar];
        _selected = NO;
        
        
        
        
    }
    
    return self;
}

- (void)setTopArr:(NSMutableArray *)topArr
{
    _topArr = topArr;
    if (!self.topScr) {
        [self setUpTopListItems];
        
    } else {
        [self.topScr removeFromSuperview];
        [self setUpTopListItems];

    }
    
}

- (void)setBottomArr:(NSMutableArray *)bottomArr
{
    _bottomArr = bottomArr;
        [self.labelMessage removeFromSuperview];
    [self.bottomScr removeFromSuperview];
        [self creatMessageBar];
        [self setUpBottomListItems];
  
   
}
/*topItems布局*/
- (void)setUpTopListItems
{
    CGFloat rowCount = self.topArr.count / 4;
    CGFloat maxIndex = self.topArr.count % 4;
    
    CGFloat height = (maxIndex == 0) ? 40 * (rowCount + 1) :
    40 * (rowCount + 1 + maxIndex/maxIndex);
    CGRect frame = CGRectMake(0, 30, self.width, height);
    _topScr = [[UIScrollView alloc] initWithFrame:frame];
    [self addSubview:_topScr];
#pragma mark - 外层控制层数
    // 判断布局 rowCount不足4个一种布局 四个以上判断是否有余数
    if (rowCount == 0) {
        for (int j = 0; j < maxIndex; j++)
        {
            JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(10+(10  + ITEMW) * j, 10 , ITEMW, 30)];
            item.location = top;
            item.dic = [self.topArr objectAtIndex:j];
            item.state = self.selected ? longPressState:commonState;
            item.deleteImg.hidden = self.selected ? NO : YES;

            [self.itemsArr addObject:item];
            item.tag = 1000 + j;
#pragma - mark 添加手势
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
            [item addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)]];
            item.text = [self.topArr objectAtIndex:j][@"title"];
            if (j == 0) {
                item.backgroundColor = [UIColor redColor];
                item.state = commonState;
                item.deleteImg.hidden = YES;

            } else {
                item.backgroundColor = [UIColor grayColor];
                item.alpha = 0.3;
            }
            
            [self.topScr addSubview:item];
            
            
        }

    }
    else
    {
        if (maxIndex == 0) {
            for (int i = 0; i < rowCount; i++) {
                for (int j = 0; j < 4; j++)
                {
                    JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(10+(10  + ITEMW) * j, 10 + i * 40, ITEMW, 30)];
                    item.location = top;

                    item.state = self.selected ? longPressState:commonState;
                    item.deleteImg.hidden = self.selected ? NO : YES;
                    [self.itemsArr addObject:item];
                    item.tag = 1000 + i * 4 +j;
                    [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
                    [item addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)]];
                    item.text = [self.topArr objectAtIndex:i * 4 + j][@"title"];
                     item.dic = [self.topArr objectAtIndex:i * 4 + j];
                 
                    if (i == 0 && j == 0) {
                        item.backgroundColor = [UIColor redColor];
                        item.state = commonState;
                        item.deleteImg.hidden = YES;
                    }else
                    {
                        item.backgroundColor = [UIColor grayColor];
                        
                        item.alpha = 0.3;
                    }
                    
                    [self.topScr addSubview:item];
                    
        }
    }
            
            
}
        else {

            for (int i = 0; i <= rowCount; i++) {
                if (i != rowCount) {
                    for (int j = 0; j < 4; j++)
                    {
                        JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(10+(10  + ITEMW) * j, i * 40 + 10, ITEMW, 30)];
                        item.location = top;
                        item.deleteImg.hidden = self.selected ? NO : YES;                        item.state = self.selected ? longPressState:commonState;                        [self.itemsArr addObject:item];
                        item.tag = 1000 + i * 4 +j;
                        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
                        [item addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)]];

                        item.text = [self.topArr objectAtIndex:i * 4 + j][@"title"];
                         item.dic = [self.topArr objectAtIndex:i * 4 + j];
                        if (i == 0 && j == 0) {
                            item.backgroundColor = [UIColor redColor];
                            item.state = commonState;
                            item.deleteImg.hidden = YES;
                        } else {
                            item.backgroundColor = [UIColor grayColor];
                            item.alpha = 0.3;

                        }
                        [self.topScr addSubview:item];
                    }

                }
                else {
                    for (int j = 0; j < maxIndex; j++)
                    {
                        JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(10+(10  + ITEMW) * j,i * 40 +10, ITEMW, 30)];
                        item.location = top;
                        item.deleteImg.hidden = self.selected ? NO : YES;
                        item.state = self.selected ? longPressState:commonState;                        [self.itemsArr addObject:item];
                        item.tag = 1000 + rowCount * 4 + j;
                        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
                        [item addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)]];

                        item.text = [self.topArr objectAtIndex:i * 4 + j][@"title"];
                         item.dic = [self.topArr objectAtIndex:i * 4 + j];
                        item.backgroundColor = [UIColor grayColor];
                        item.alpha = 0.3;
                        [self.topScr addSubview:item];
                        
                    }

                }
             }
        }
    
}
    

}

- (void)creatMessageBar
{
    CGRect frame = self.topArr.count % 4 > 0 ? CGRectMake(0, 40 * ((int)self.topArr.count / 4 + 2), self.width, 30):
    CGRectMake(0, 40 * ((int)self.topArr.count / 4 + 1) , self.width, 30);
    
    self.labelMessage = [[UILabel alloc] initWithFrame:frame];
    self.labelMessage.text = @"       点击添加";
    self.labelMessage.backgroundColor = [UIColor grayColor];
    self.labelMessage.alpha = 0.3;
    [self addSubview:self.labelMessage];

}
/*bottomItems布局*/
- (void)setUpBottomListItems
{
    int rowCount = (int)self.bottomArr.count / 4;
    int maxIndex = self.bottomArr.count % 4;
    
    NSInteger topCount = self.topArr.count;
    
    CGRect frame = CGRectMake(0, self.labelMessage.origin.y + 30, self.width, self.height - self.topScr.height - 30 );
    _bottomScr = [[UIScrollView alloc] initWithFrame:frame];
    [self addSubview:_bottomScr];
#pragma mark - 外层控制层数
    // 判断布局 rowCount不足4个一种布局 四个以上判断是否有余数
    if (rowCount == 0) {
        for (int j = 0; j < maxIndex; j++)
        {
            JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(10+(10  + ITEMW) * j, 10, ITEMW, 30)];
            item.location = bottom;
            item.deleteImg.hidden = self.selected ? NO : YES;
            item.state = self.selected ? longPressState:commonState;            [self.itemsArr addObject:item];
            item.tag = 1000 + j + topCount;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
            item.text = [self.bottomArr objectAtIndex:j][@"title"];
       item.dic = [self.bottomArr objectAtIndex:j];
                item.backgroundColor = [UIColor grayColor];
                item.alpha = 0.3;
        
            
            [_bottomScr addSubview:item];
            
            
        }
        
    }
    else
    {
        if (maxIndex == 0) {
            for (int i = 0; i < rowCount; i++) {
                for (int j = 0; j < 4; j++)
                {
                    JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(10+(10  + ITEMW) * j, 10 + i * 40, ITEMW, 30)];
                    item.location = bottom;
                    item.deleteImg.hidden = self.selected ? NO : YES;
                    item.state = self.selected ? longPressState:commonState;
                    [self.itemsArr addObject:item];
                    item.tag = 1000 + i * 4 +j + topCount;
                    [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
                    item.text = [self.bottomArr objectAtIndex:i * 4 + j][@"title"];
                    item.dic = [self.bottomArr objectAtIndex:i * 4 + j];
                        item.backgroundColor = [UIColor grayColor];
                        
                        item.alpha = 0.3;

                    
                    [_bottomScr addSubview:item];
                    
                }
            }
            
            
        }
        else {
            
            for (int i = 0; i <= rowCount; i++) {
                if (i != rowCount) {
                    for (int j = 0; j < 4; j++)
                    {
                        JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(10+(10  + ITEMW) * j, 10 + i * 40, ITEMW, 30)];
                        item.location = bottom;
                        item.deleteImg.hidden = self.selected ? NO : YES;
                        item.state = self.selected ? longPressState:commonState;                        [self.itemsArr addObject:item];
                        item.tag = 1000 + i * 4 +j + topCount;
                        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
                        
                        item.text = [self.bottomArr objectAtIndex:i * 4 + j][@"title"];
                         item.dic = [self.bottomArr objectAtIndex:i * 4 + j];
                            item.backgroundColor = [UIColor grayColor];
                            item.alpha = 0.3;
                        
                        [_bottomScr addSubview:item];
                    }
                    
                } else {
                    for (int j = 0; j < maxIndex; j++)
                    {
                        JWItem *item = [[JWItem alloc] initWithFrame:CGRectMake(10+(10  + ITEMW) * j, 10 + i * 40, ITEMW, 30)];
                        item.location = bottom;
                        item.deleteImg.hidden = self.selected ? NO : YES;
                        item.state = self.selected ? longPressState:commonState;                        [self.itemsArr addObject:item];
                        item.tag = 1000 + rowCount * 4 + j +topCount;
                        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
                        
                        item.text = [self.bottomArr objectAtIndex:i * 4 + j][@"title"];
                        item.dic = [self.bottomArr objectAtIndex:i * 4 + j];
                        item.backgroundColor = [UIColor grayColor];
                        item.alpha = 0.3;
                        [_bottomScr addSubview:item];
                    }
                    
                }
            }
        }

    
    
}
}

/*轻点手势关联方法*/
- (void)itemTap:(UITapGestureRecognizer *)tap
{
    JWItem *item = (JWItem *)tap.view;
    // 判断Item位置
    if (item.location == top)
    {
        // 判断Item状态
        if (item.state == commonState) {
            // 判断是否为默认
            if (item.tag == 1000) {
                for (JWItem *item in self.itemsArr) {
                    NSLog(@"点第一个了 ");
                        item.state = commonState;
                        item.deleteImg.hidden = YES;
                }

            }
            [self.delegate itemTapClick:item.tag - 1000];
        } else {
            JWNewsDB *tool = [JWNewsDB share];
            [tool insertKeyValues:item.dic TableName:NEWSOTHERT];
            [tool deleteDataFrom:NEWSDEFAULTT Dic:item.dic];
            NSLog(@"%@",item.dic);
            self.topArr = [[[JWNewsDB share] selectKeyTypes:@{@"title":@"text",@"url":@"text"
                                                              }  fromTable:NEWSDEFAULTT] mutableCopy];
            self.bottomArr = [[[JWNewsDB share] selectKeyTypes:@{@"title":@"text",@"url":@"text"
                                                                 }  fromTable:NEWSOTHERT] mutableCopy];
        }
    }
    else
    {
        JWNewsDB *tool = [JWNewsDB share];
        [tool insertKeyValues:item.dic TableName:NEWSDEFAULTT];
        [tool deleteDataFrom:NEWSOTHERT Dic:item.dic];
        self.topArr = [[[JWNewsDB share] selectKeyTypes:@{@"title":@"text",@"url":@"text"
                                                          }  fromTable:NEWSDEFAULTT] mutableCopy];
        self.bottomArr = [[[JWNewsDB share] selectKeyTypes:@{@"title":@"text",@"url":@"text"
                                                          }  fromTable:NEWSOTHERT] mutableCopy];
    }
}

#pragma - mark 长按手势
- (void)longPressClick:(UILongPressGestureRecognizer *)tap
{
    self.selected = YES;
   self.bar.makeSure.hidden = NO;
    self.bar.label.text = @"  频道编辑";
    for (JWItem *item in self.itemsArr) {
        if (item.tag == 1000) {
            item.state = commonState;
            item.deleteImg.hidden = YES;
        }
        else {
            item.state = longPressState;
            item.deleteImg.hidden = NO;
        }
    }


}


@end
