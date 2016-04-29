//
//  JWNewsViewController.m
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNewsViewController.h"
#import "JWTitleView.h"
#import "JWItem.h"
#import "JWNewsTableViewController.h"
#import "JWNewsMainScr.h"
#import "JWArrowBtn.h"
#import "JWListView.h"
#import "JWNewsDB.h"
#define URL @"http://api.sina.cn/sinago/list.json?uid=c6a4f5df5110dd57&s=20&p=1&channel=%@"
#define MORE @"http://api.sina.cn/sinago/list.json?uid=c6a4f5df5110dd57&s=20&p=%ld&channel="

@interface JWNewsViewController ()<UIScrollViewDelegate,JWListViewDelegate>

@property(nonatomic,copy)NSMutableArray *defaultArr;

@property(nonatomic,copy)NSMutableArray *otherArr;
/*标题scr*/
@property(nonatomic,strong)JWTitleView *titleView;
/*主Scr*/
@property(nonatomic,strong)JWNewsMainScr *mainScr;
/*下拉菜单按钮*/
@property(nonatomic,strong)JWArrowBtn *arrowBtn;
/*可编辑下拉菜单*/
@property(nonatomic,strong)JWListView *listView;

@end

@implementation JWNewsViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainScrContentOffset:) name:@"mainScrContentOffset" object:nil];

        
    }
    
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUIView];
    
}

- (void)setUpUIView
{
    [self setValue:nil forKey:@"childViewControllers"];
    for (int i = 0; i < self.defaultArr.count; i++) {
        JWNewsTableViewController *temp = [[JWNewsTableViewController alloc] init];
        temp.url = [NSString stringWithFormat:URL,[self.defaultArr objectAtIndex:i][@"url"]];
        temp.more = [[NSString stringWithFormat:@"%@",MORE] stringByAppendingString:[self.defaultArr objectAtIndex:i][@"url"]];
        [self addChildViewController:temp];
    }
    
    [self setUpView];
    
    [self setUpMainScrollView];
    
    [self setUpPullDownListView];
}
- (void)getDataFromDB
{
    self.defaultArr = [[[JWNewsDB share] selectKeyTypes:@{@"title":@"text",@"url":@"text"
                                                          }  fromTable:NEWSDEFAULTT] mutableCopy];
    self.otherArr = [[[JWNewsDB share] selectKeyTypes:@{@"title":@"text",@"url":@"text"
                                                        }  fromTable:NEWSOTHERT] mutableCopy];
}
// 创建头滚动视图
- (void)setUpView
{
    
    // 创建滚动SCR
      [self.titleView removeFromSuperview];
      [self.arrowBtn removeFromSuperview];
        _titleView = [[JWTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 30, kTITLEH+30)];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.defaultArr = self.defaultArr;
        [self.view addSubview:_titleView];
    
    
        _arrowBtn = [[JWArrowBtn alloc] initWithFrame:CGRectMake(self.view.width - kTITLEH + 5, 5, kTITLEH-10, kTITLEH-10)];
        _arrowBtn.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_arrowBtn];
        WEAK(ws);
        _arrowBtn.ArrowBlock = ^()
        {
            __strong typeof(ws)strongSelf = ws;
            CGAffineTransform transform = strongSelf.arrowBtn.transform;
            [UIView animateWithDuration:1 animations:^{
                strongSelf.arrowBtn.transform = CGAffineTransformRotate(transform, 2 * M_PI);               strongSelf.listView.transform = (strongSelf.listView.y<0)?CGAffineTransformMakeTranslation(0, SCREENHEIGHT-30):CGAffineTransformMakeTranslation(0, -SCREENHEIGHT);
                
            }];
            
        };


}
/*操作较为复杂后重新创建*/
- (void)setUpMainScrollView
{
    [self.mainScr removeFromSuperview];
    self.mainScr = [[JWNewsMainScr alloc] initWithFrame:CGRectMake(0, 30, SCREENWIDTH, SCREENHEIGHT - 94) Arr:self.defaultArr ViewController:self];
    [self.view addSubview:self.mainScr];
    
}


/*创建下拉菜单*/
- (void)setUpPullDownListView
{
    

    [self.listView removeFromSuperview];
        _listView = [[JWListView alloc] initWithFrame:CGRectMake(0, kTITLEH-SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT-108)];
        _listView.topArr = self.defaultArr;
        _listView.bottomArr = self.otherArr;
        _listView.delegate = self;
        [self.view addSubview:_listView];

    WEAK(ws);
    self.listView.bar.arrowBtn.ArrowBlock = ^()
    {
        __strong typeof(ws)strongSelf = ws;

        [UIView animateWithDuration:1 animations:^{
            strongSelf.arrowBtn.transform = CGAffineTransformMakeRotation(2 * M_PI);            strongSelf.listView.transform = CGAffineTransformMakeTranslation(0, -SCREENHEIGHT);
            for (JWItem *item in strongSelf.listView.itemsArr) {
                item.state = commonState;
                item.deleteImg.hidden = YES;
            }
            
        }];

    };

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.view = nil;
}
#pragma Scr协议
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
}
//上随下动的实现
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / SCREENWIDTH;
    self.titleView.currentItem = index ;

    if (index >= 2) {
        self.titleView.contentOffset = CGPointMake((index - 2) * (SCREENWIDTH)/ 5, 0);
    }
    JWNewsTableViewController *newsVC = [self.childViewControllers objectAtIndex:index];
    if (newsVC.view.superview)return;
    
    newsVC.view.frame = scrollView.bounds;
    [self.mainScr addSubview:newsVC.view];
}

#pragma mark - 通知方法的实现
- (void)mainScrContentOffset:(NSNotification *)noti
{
    NSInteger temp = [noti.userInfo[@"index"] integerValue];
    
    self.mainScr.contentOffset = CGPointMake( temp * SCREENWIDTH, 0);
    
    JWNewsTableViewController *newsVC = [self.childViewControllers objectAtIndex:[noti.userInfo[@"index"] integerValue]];

    if (newsVC.view.superview)return;
    
    newsVC.view.frame = self.mainScr.bounds;
    [self.mainScr addSubview:newsVC.view];
//    self.mainScr.contentOffset = CGPointMake([noti.userInfo[@"index"] integerValue] * SCREENWIDTH, 0);
    self.titleView.currentItem = [noti.userInfo[@"index"] integerValue] ;
    self.listView.transform = CGAffineTransformMakeTranslation(0, -SCREENHEIGHT);

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"mainScrContentOffset" object:nil];
}
/*代理方法的实现*/
- (void)itemTapClick:(NSInteger)index
{
#pragma mark - 刷新数据重新铺设界面 
    // 可以优化判断操作类型 只是添加或者删除的话对应各自方法 这个地方重新铺有点浪费资源了 有时间再优化吧^_^
    [self getDataFromDB];
    [self setUpUIView];
    self.mainScr.contentOffset = CGPointMake(index * SCREENWIDTH, 0);

    JWNewsTableViewController *newsVC = [self.childViewControllers objectAtIndex:index];
    if (newsVC.view.superview)return;
    
    newsVC.view.frame = self.mainScr.bounds;
    [self.mainScr addSubview:newsVC.view];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",index] forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mainScrContentOffset" object:nil userInfo:dic];
//    [newsVC.tableView.mj_header beginRefreshing];
    self.titleView.currentItem = index ;
    self.listView.transform = CGAffineTransformMakeTranslation(0, -SCREENHEIGHT);
    
}
- (NSMutableArray *)defaultArr
{
    if (!_defaultArr) {
        _defaultArr = [[[JWNewsDB share] selectKeyTypes:@{@"title":@"text",@"url":@"text"
                                                          }  fromTable:NEWSDEFAULTT] mutableCopy];
    }
    
    return _defaultArr;
}

- (NSMutableArray *)otherArr
{
    if (!_otherArr) {
        _otherArr = [[[JWNewsDB share] selectKeyTypes:@{@"title":@"text",@"url":@"text"
                                                        }  fromTable:NEWSOTHERT] mutableCopy];
    }
    return _otherArr;
}
@end
