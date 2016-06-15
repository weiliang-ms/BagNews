//
//  JWTourViewModel.m
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourViewModel.h"
#import "JWTourCustomModel.h"
#import "JWTourLocationsModel.h"
#import "JWTourViewController.h"
#import "JWWebViewController.h"
@implementation JWTourViewModel
+ (void)getNewsData:(NSString *)url ViewController:(UIViewController *)viewController TableView:(UITableView *)tableView
{
    [super getNewsData:url ViewController:viewController TableView:tableView];
    JWTourViewController *tour = (JWTourViewController *)viewController;
    __block NSMutableArray *dataArr = [NSMutableArray array];
    __block NSMutableArray *allArr = [NSMutableArray array];
    [JWNetTool getWithURL:url Parameter:nil Progress:nil Success:^(id result) {
        NSDictionary *dic = [result objectForKey:@"data"];
        tour.next_start = [dic objectForKey:@"next_start"];
        
        NSArray *elements = [dic objectForKey:@"elements"];
        for (NSDictionary *temp in elements) {
            NSArray *datas = [temp objectForKey:@"data"];
            if ([[[datas firstObject] class] isSubclassOfClass:[NSArray class]]) {
                for (NSDictionary *dics in [datas firstObject]) {
                    [dataArr addObject:[JWTourCustomModel modelWithDic:dics]];
                }
            }
            else
            {
                for (NSDictionary *dics in datas) {
                    [dataArr addObject:[JWTourCustomModel modelWithDic:dics]];
                }

            }
            
        }
         tour.models = dataArr;
         tableView.tableHeaderView = (UIView *)tour.carouseView;
         [tableView reloadData];
         [tableView.mj_header endRefreshing];
         [dataArr removeAllObjects];
        
        NSArray *searchArr = [dic objectForKey:@"search_data"];
        for (NSDictionary *temp in [searchArr firstObject][@"elements"]) {
            [dataArr addObject:[JWTourLocationsModel modelWithDic:temp]];
        }
        [allArr addObject:dataArr];
        [dataArr removeAllObjects];
        for (NSDictionary *temp in [searchArr lastObject][@"elements"]) {
            [dataArr addObject:[JWTourLocationsModel modelWithDic:temp]];
        }
        [allArr addObject:dataArr];
        [dataArr removeAllObjects];
        tour.locations = allArr;
        
        
        } Failure:^(id result) {
        
            NSDictionary *dic = [result objectForKey:@"data"];
            tour.next_start = [dic objectForKey:@"next_start"];
            NSArray *elements = [dic objectForKey:@"elements"];
            for (NSDictionary *temp in elements) {
                for (NSDictionary *dics in [temp[@"data"] firstObject]) {
                    [dataArr addObject:[JWTourCustomModel modelWithDic:dics]];
                }
            }
            tour.models = dataArr;
            tableView.tableHeaderView = (UIView *)tour.carouseView;
            [tableView reloadData];
            [tableView.mj_header endRefreshing];
            dataArr = nil;
            
            NSArray *searchArr = [dic objectForKey:@"search_data"];
            for (NSDictionary *temp in [searchArr firstObject][@"elements"]) {
                [dataArr addObject:[JWTourLocationsModel modelWithDic:temp]];
            }
            [allArr addObject:dataArr];
            [dataArr removeAllObjects];
            for (NSDictionary *temp in [searchArr lastObject][@"elements"]) {
                [dataArr addObject:[JWTourLocationsModel modelWithDic:temp]];
            }
            [allArr addObject:dataArr];
            [dataArr removeAllObjects];
            tour.locations = allArr;
            
        
    } HttpHeader:nil ResponseType:ResponseTypeJSON];
}

+ (void)getMoreData:(NSString *)url ViewController:(UIViewController *)viewController TableView:(UITableView *)tableView DataArr:(NSMutableArray *)dataArr
{
    [super getMoreData:url ViewController:viewController TableView:tableView DataArr:dataArr];
    JWTourViewController *tour = (JWTourViewController *)viewController;
    __block NSMutableArray *arr = [NSMutableArray array];
    
    [JWNetTool getWithURL:url Parameter:nil Progress:nil Success:^(id result) {
        NSDictionary *dic = [result objectForKey:@"data"];
        tour.next_start = [dic objectForKey:@"next_start"];
        NSArray *list = [dic objectForKey:@"elements"];
        [arr addObjectsFromArray:dataArr];
        
        for (NSDictionary *temp in list) {
            NSArray *datas = [temp objectForKey:@"data"];
                for (NSDictionary *dics in datas) {
                    [arr addObject:[JWTourCustomModel modelWithDic:dics]];
                    tour.models = arr;
                    [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:arr.count - 17 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                }
            
            }

        [tableView.mj_footer endRefreshing];
    } Failure:^(id result) {
        
        NSDictionary *dic = [result objectForKey:@"data"];
        tour.next_start = [dic objectForKey:@"next_start"];
        NSArray *list = [dic objectForKey:@"elements"];
        [arr addObjectsFromArray:dataArr];
        
        for (NSDictionary *temp in list) {
            NSArray *datas = [temp objectForKey:@"data"];
            for (NSDictionary *dics in datas) {
                [arr addObject:[JWTourCustomModel modelWithDic:dics]];
                tour.models = arr;
                [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:arr.count - 17 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }

        [tableView.mj_footer endRefreshing];
        
        
    } HttpHeader:nil ResponseType:ResponseTypeJSON];
    

}
+ (void)selectedCellTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath ViewController:(UIViewController *)viewController Link:(NSString *)link
{
    
    [super selectedCellTableView:tableView IndexPath:indexPath ViewController:viewController Link:link];
    JWWebViewController *web = [[JWWebViewController alloc] init];
    web.url = link;
    [viewController.navigationController pushViewController:web animated:YES];
}

@end
