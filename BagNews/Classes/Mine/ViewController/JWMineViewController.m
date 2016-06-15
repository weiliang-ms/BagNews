//
//  JWMineViewController.m
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWMineViewController.h"
#import "JWListenModel.h"
#import "JWListenTableViewCell.h"
#import <MJRefresh.h>
#import "JWLeftListTableViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "JWListenDetailViewController.h"
#import "MHNetWorkTask.h"
#define LISTENCELLHEIGHT 100
#define REQUESTURL @"http://admin.tingwen.me/index.php/api/interface/postList"

@interface JWMineViewController ()

@property(nonatomic,retain)NSMutableArray *dataArr;

@property(nonatomic,assign)NSUInteger count;

@property(nonatomic,retain)NSArray *arrayList;

@property(nonatomic,retain)NSDictionary *pageInfo;

@property(nonatomic,retain)UITableView *listTableView;

@end

@implementation JWMineViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
     self.navigationController.navigationBar.alpha = 1 - (self.tableView.contentOffset.y / SCREENHEIGHT);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tableView registerClass:[JWListenTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JWListenTableViewCell class])];
    self.pageInfo = self.arrayList.firstObject;
//    self.navigationItem.title = self.pageInfo[@"title"];
    self.dataArr = [NSMutableArray new];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadDataInfo)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(newDataInfo)];
    [self.tableView.mj_header beginRefreshing];
    
    
    [self creatUI];
    
    UIImage *image = [UIImage imageNamed:@"left"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBarBtn= [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(enterLeftNavication)];
    
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(messageInfo:) name:@"changeInfo" object:nil];
}



-(void)messageInfo:(NSNotification*)sender{
    
    self.pageInfo = [sender userInfo];
    self.navigationItem.title = self.pageInfo[@"title"];
    [self.tableView.mj_header beginRefreshing];
}

-(void)enterLeftNavication{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
    
}

-(void)creatUI{
    
    
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREENWIDTH-100, 0, 100, SCREENHEIGHT)];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor colorWithRed:0.232 green:0.784 blue:1.000 alpha:1.000];
    self.listTableView.alpha = 0.0;
    [self.listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalCell"];
    [self.view addSubview:self.listTableView];
    
}

//信息懒加载
-(NSArray *)arrayList{
    if (_arrayList == nil) {
        _arrayList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ListenURLs.plist" ofType:nil]];
    }
    return _arrayList;
}
//刷新数据
-(void)reloadDataInfo{
    
    self.count = 1;
    if (self.dataArr.count) {
        self.dataArr = [NSMutableArray array];
    }
    [MHNetWorkTask postWithURL:REQUESTURL withBody:[NSString stringWithFormat:@"limit=10&page=%ld&term_id=%@",(unsigned long)self.count,self.pageInfo[@"term_id"]] withBodyType:BodyTypeString withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        if ([result objectForKey:@"status"]) {
            result = [result objectForKey:@"results"];
            for (NSDictionary *dic in result) {
                JWListenModel *model = [JWListenModel objectWithDict:dic];
                model.ID = dic[@"id"];
                [self.dataArr addObject:model];
            }
        }
        self.count++;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } withFail:^(NSError *error) {
        
    }];
    
}
//更多数据
-(void)newDataInfo{
    [MHNetWorkTask postWithURL:REQUESTURL withBody:[NSString stringWithFormat:@"limit=10&page=%ld&term_id=%@",(unsigned long)self.count,self.pageInfo[@"term_id"]] withBodyType:BodyTypeString withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        if ([result objectForKey:@"status"]) {
            result = [result objectForKey:@"results"];
            for (NSDictionary *dic in result) {
                JWListenModel *model = [JWListenModel objectWithDict:dic];
                model.ID = dic[@"id"];
                [self.dataArr addObject:model];
                [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                
            }
        }
        self.count++;
        // [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } withFail:^(NSError *error) {
        
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
    if (tableView == self.listTableView) {
        return self.arrayList.count;
    }
    else{
        return self.dataArr.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.listTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];
        cell.textLabel.text = self.arrayList[indexPath.row][@"title"];
        return cell;
        
    }
    else{
        JWListenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JWListenTableViewCell class])];
        JWListenModel *model = self.dataArr[indexPath.row];
        cell.model = model;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.listTableView) {
        return 60;
    }
    else{
        return LISTENCELLHEIGHT;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JWListenModel *model = self.dataArr[indexPath.row];JWListenDetailViewController *detailVC = [JWListenDetailViewController new];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navigationController.navigationBar.alpha = 1 - (scrollView.contentOffset.y / SCREENHEIGHT);
}

@end
