//
//  JWTourNearVM.m
//  BagNews
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourNearVM.h"
#import "JWTourNearViewController.h"
#import "JWTourNearModel.h"
#import "JWWebViewController.h"
@implementation JWTourNearVM
+ (void)getNewsData:(NSString *)url ViewController:(UIViewController *)viewController TableView:(UITableView *)tableView
{
    [super getNewsData:url ViewController:viewController TableView:tableView];
    JWTourNearViewController *tour = (JWTourNearViewController *)viewController;
    __block NSMutableArray *dataArr = [NSMutableArray array];
    [JWNetTool getWithURL:url Parameter:nil Progress:nil Success:^(id result) {
        NSArray *items = [result objectForKey:@"items"];
        for (NSDictionary *dict in items) {
            [dataArr addObject:[JWTourNearModel modelWithDic:dict]];
        }
        tour.models = dataArr;
        [tour.tableView reloadData];
        [tour.tableView.mj_header endRefreshing];

        
        
    } Failure:^(id result) {
        
        NSArray *items = [result objectForKey:@"items"];
        for (NSDictionary *dict in items) {
            [dataArr addObject:[JWTourNearModel modelWithDic:dict]];
        }
        tour.models = dataArr;
        [tour.tableView reloadData];
        [tour.tableView.mj_header endRefreshing];

        
    } HttpHeader:nil ResponseType:ResponseTypeJSON];

}
+ (void)selectedCellTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath ViewController:(UIViewController *)viewController Link:(NSString *)link
{
    [super selectedCellTableView:tableView IndexPath:indexPath ViewController:viewController Link:link];
    JWWebViewController *web = [[JWWebViewController alloc] init];
    web.url = link;
    [viewController.navigationController pushViewController:web animated:YES];
}
+ (void)getMoreData:(NSString *)url ViewController:(UIViewController *)viewController TableView:(UITableView *)tableView DataArr:(NSMutableArray *)dataArr
{
    [super getMoreData:url ViewController:viewController TableView:tableView DataArr:dataArr];
    JWTourNearViewController *tour = (JWTourNearViewController *)viewController;
    __block NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:dataArr];
    static NSInteger index = 0;
    index+=20;
    NSLog(@"%ld",index);
    NSString *temp = [NSString stringWithFormat:url,index];
    [JWNetTool getWithURL:temp Parameter:nil Progress:nil Success:^(id result) {
        NSArray *items = [result objectForKey:@"items"];
        for (NSDictionary *dict in items) {
            [arr addObject:[JWTourNearModel modelWithDic:dict]];
            tour.models = arr;
            [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:arr.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
        [tableView.mj_footer endRefreshing];
        
        
        
    } Failure:^(id result) {
        
        NSArray *items = [result objectForKey:@"items"];
        for (NSDictionary *dict in items) {
            [arr addObject:[JWTourNearModel modelWithDic:dict]];
            tour.models = arr;
            [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:arr.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
        [tableView.mj_footer endRefreshing];
        
        
    } HttpHeader:nil ResponseType:ResponseTypeJSON];

}
@end
