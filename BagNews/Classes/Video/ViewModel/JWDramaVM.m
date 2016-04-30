
//
//  JWDramaVM.m
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaVM.h"
#import "JWNetTool.h"
#import "JWVideoViewController.h"
#import "JWDramaModel.h"
#import "JWDaramHeadModel.h"
NSString *const head = @"http://api.bilibili.com/online_list?_device=android&_hwid=130a7709aeac1793&appkey=c1b107428d337928&platform=android&typeid=13&sign=cb5cf6d54ed92fc25c4a8b4292a46692";
@interface JWDramaVM ()
@end
@implementation JWDramaVM
+ (void)getNewsWithUrl:(NSString *)url CollectionView:(UICollectionView *)collectionView ViewController:(JWVideoViewController *)viewController
{
    static NSInteger index = 0;
    if (index == 0){
    __block NSMutableArray *dataArr = [NSMutableArray array];
    [JWNetTool getWithURL:url Parameter:nil Progress:nil Success:^(id result) {
        NSArray *list = [result objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            [dataArr addObject:[JWDramaModel objectWithDict:dic]];
        }
             viewController.models = dataArr;
        [self getHeadDataWithUrl:head CollectionView:collectionView ViewController:viewController];
        
    } Failure:^(id result) {
        
        NSArray *list = [result objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            [dataArr addObject:[JWDramaModel objectWithDict:dic]];
        }
        viewController.models = dataArr;
        [collectionView reloadData];
        [collectionView.mj_header endRefreshing];
    } HttpHeader:nil ResponseType:ResponseTypeJSON];}
    else{
                [self getHeadDataWithUrl:head CollectionView:collectionView ViewController:viewController];
    }
}

+ (void)getHeadDataWithUrl:(NSString *)url CollectionView:(UICollectionView *)collectionView ViewController:(JWVideoViewController *)viewController
{
    __block NSMutableArray *dataArr = [NSMutableArray array];
    [JWNetTool getWithURL:url Parameter:nil Progress:nil Success:^(id result) {
        NSDictionary *list = [result objectForKey:@"list"];
//        for (NSDictionary *dic in list) {
//            [dataArr addObject:[JWDramaModel objectWithDict:dic]];
//        }
        for (int i = 0; i < list.allKeys.count; i++) {
            NSString *key = [NSString stringWithFormat:@"%zd",i];
            [ dataArr addObject:[JWDaramHeadModel objectWithDict:[list objectForKey:key]]];
        }
        viewController.header.arr = dataArr;
        [viewController.header.collectionView reloadData];
        [collectionView reloadData];
        [collectionView.mj_header endRefreshing];
        
        
    } Failure:^(id result) {
        
        NSArray *list = [result objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            [dataArr addObject:[JWDaramHeadModel objectWithDict:dic]];
        }
        viewController.header.arr = dataArr;
        [collectionView reloadData];
        [viewController.header.collectionView reloadData];
        [collectionView.mj_header endRefreshing];
    } HttpHeader:nil ResponseType:ResponseTypeJSON];
}

@end
