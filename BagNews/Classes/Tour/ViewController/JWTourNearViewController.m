//
//  JWTourNearViewController.m
//  BagNews
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourNearViewController.h"
#import "JWTourNearVM.h"
#import "JWTourNearModel.h"
#import "JWTourNearTableViewCell.h"
#define kROWH 150 * self.view.width / SCREENWIDTH
@interface JWTourNearViewController ()

@property(copy,nonatomic)NSString *news;

@property(copy,nonatomic)NSString *more;
@end

@implementation JWTourNearViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = kROWH;
self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
    
    [JWTourNearVM getNewsData:self.news ViewController:self TableView:self.tableView];
}];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [JWTourNearVM getMoreData:self.more ViewController:self TableView:self.tableView DataArr:(NSMutableArray *)self.models];
    }];
    
}
- (void)loadView
{
    [super loadView];
    [self.tableView registerNib:[UINib nibWithNibName:@"JWTourNearTableViewCell" bundle:nil] forCellReuseIdentifier:@"JWTourNearTableViewCell"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JWTourNearTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JWTourNearTableViewCell" forIndexPath:indexPath];
    JWTourNearModel *model = self.models[indexPath.row];
    cell.model = model;
    return cell;
}
- (NSArray *)models
{
    if (!_models) {
        _models = [NSArray array];
    }
    
    return _models;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JWTourNearModel *model = self.models[indexPath.row];
    [JWTourNearVM selectedCellTableView:tableView IndexPath:indexPath ViewController:self Link:[NSString stringWithFormat:@"http://web.breadtrip.com/%@",model.slug_url]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    self.news = [NSString stringWithFormat:url,@"0",39.92,116.46];
    [self.tableView.mj_header beginRefreshing];
    self.more = [NSString stringWithFormat:url,@"%ld",39.92,116.46];
}


@end