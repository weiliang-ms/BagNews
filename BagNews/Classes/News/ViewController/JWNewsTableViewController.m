//
//  JWNewsTableViewController.m
//  BagNews
//
//  Created by 微凉 on 16/4/23.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNewsTableViewController.h"
#import "JWNewsViewModel.h"
#import "JWNewsFactoryCell.h"
#import "JWNewsModel.h"
#import "JWCarouselFigureView.h"
#define kWIDTH 240 * self.view.width / SCREENWIDTH
@interface JWNewsTableViewController ()


@end
@implementation JWNewsTableViewController
- (NSMutableArray *)dataArr
{
    
    if (!_dataArr) {
        _dataArr = [ NSMutableArray array];
    }
    
    return _dataArr;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    
    return self;
}
- (JWCarouselFigureView *)carouseView
{
        if (!_carouseView) {
            _carouseView = [[JWCarouselFigureView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kWIDTH)];
    
            NSMutableArray *temp = [NSMutableArray array];
            NSMutableArray *titleArr = [NSMutableArray array];
            for (int i = 0; i < 5; i++) {
                JWNewsModel *model = [self.dataArr objectAtIndex:i];
                [temp addObject:model.kpic];
                [titleArr addObject:model.title];
            }
            _carouseView.pics = temp;
            _carouseView.titles = titleArr;
            WEAK(ws);
#pragma - mark 轮播图点击回调block
            _carouseView.CallBack = ^(NSInteger index)
            {
                __strong typeof(ws)StrongSelf = ws;
                JWNewsModel *model = [StrongSelf.dataArr objectAtIndex:index];
#pragma - mark 获取数据交给VM处理跳转
                [JWNewsViewModel selectedCellTableView:nil IndexPath:nil ViewController:StrongSelf Link:model.link];
                
                
            };
        }
    
            
    return _carouseView;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:@"mainScrContentOffset" object:nil];
    [self getDataByViewModel];
}

- (void)getDataByViewModel
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [JWNewsViewModel getNewsData:self.url ViewController:self TableView:self.tableView];
        
                }];
    [self.tableView.mj_header beginRefreshing];
#pragma mark - 下拉加载的实现
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [JWNewsViewModel getMoreData:self.more ViewController:self TableView:self.tableView DataArr:self.dataArr];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count - 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JWNewsModel *model = self.dataArr[indexPath.row + 5];
    return [JWNewsFactoryCell creatTableViewCellWithModel:model TableView:tableView IndexPath:indexPath];
 }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JWNewsModel *model = self.dataArr[indexPath.row + 5];
    [JWNewsViewModel selectedCellTableView:tableView IndexPath:indexPath ViewController:self Link:model.link];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JWNewsFactoryCell cellForRowHeightWithModel:[self.dataArr objectAtIndex:indexPath.row + 5] TableView:tableView IndexPath:indexPath];
}
- (void)refreshUI
{
    [self.tableView.mj_header beginRefreshing];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
