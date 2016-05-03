//
//  JWDramaChirldVM.m
//  BagNews
//
//  Created by 微凉 on 16/5/2.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaChirldVM.h"
#import "JWNetTool.h"
#import "JWDramaChirldModel.h"
#import "JWDramaCommentModel.h"
#import "JWDramaDetailChild.h"
#import <UIKit+AFNetworking.h>
@implementation JWDramaChirldVM
+ (void)getVideoInfo:(NSString *)url CallBack:(void (^)(NSArray *))callBack
{
    __block NSMutableArray *dataArr = [NSMutableArray array];
    [JWNetTool getWithURL:url Parameter:nil Progress:nil Success:^(id result) {
        NSArray *list = [result objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            [dataArr addObject:[JWDramaChirldModel objectWithDict:dic]];
        }
        callBack(dataArr);
    } Failure:^(id result) {
        
        NSArray *list = [result objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            [dataArr addObject:[JWDramaChirldModel objectWithDict:dic]];
        }
        callBack(dataArr);
    } HttpHeader:nil ResponseType:ResponseTypeJSON];

}
+ (void)getDramaCommentsData:(NSString *)url TableView:(UITableView *)tableView ViewController:(JWDramaDetailChild *)viewController
{
    __block NSMutableArray *dataArr = [NSMutableArray array];

    NSURL* URL = [NSURL URLWithString:url];
    
    NSURLRequest* req = [NSURLRequest requestWithURL:URL];
    
    UIWebView* web = [[UIWebView alloc] init];
    
    NSProgress* progress = nil;
    
    [web loadRequest:req progress:&progress
             success:^NSString* _Nonnull(NSHTTPURLResponse* _Nonnull response, NSString* _Nonnull HTML) {
                 
                 if (HTML != nil) {
                     tableView.sectionFooterHeight = 21;
                     NSMutableString* str = [NSMutableString stringWithString:HTML];
                     
                     [str deleteCharactersInRange:NSMakeRange(0, 43)];
                     
                     [str deleteCharactersInRange:NSMakeRange(str.length - 2, 2)];
                     
                     NSData* d = [str dataUsingEncoding:NSUTF8StringEncoding];
                     
                     NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
                     
            
                     
                     NSArray* arr02 = [NSArray arrayWithArray:[dict valueForKey:@"list"]];
                    
                     for (NSDictionary* dict in arr02) {
                        [dataArr addObject:[JWDramaCommentModel objectWithDict:dict]];
                     }
                     viewController.comments = dataArr;
                     [tableView reloadData];
                     [tableView.mj_header endRefreshing];
                 }
                 return HTML;
             }
             failure:^(NSError* _Nonnull error){
                 [tableView.mj_header endRefreshing];
             }];

}
+ (void)getMoreDramaCommentsData:(NSString *)url TableView:(UITableView *)tableView ViewController:(JWDramaDetailChild *)viewController
{
    __block NSMutableArray *dataArr = [NSMutableArray array];
    
    
    NSURL* URL = [NSURL URLWithString:url];
    
    NSURLRequest* req = [NSURLRequest requestWithURL:URL];
    
    UIWebView* web = [[UIWebView alloc] init];
    
    NSProgress* progress = nil;
    
    [web loadRequest:req progress:&progress
             success:^NSString* _Nonnull(NSHTTPURLResponse* _Nonnull response, NSString* _Nonnull HTML) {
                 
                 if (HTML != nil) {
                     tableView.sectionFooterHeight = 21;
                     NSMutableString* str = [NSMutableString stringWithString:HTML];
                     
                     [str deleteCharactersInRange:NSMakeRange(0, 43)];
                     
                     [str deleteCharactersInRange:NSMakeRange(str.length - 2, 2)];
                     
                     NSData* d = [str dataUsingEncoding:NSUTF8StringEncoding];
                     
                     NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];

                     NSArray* arr02 = [NSArray arrayWithArray:[dict valueForKey:@"list"]];
                     [dataArr addObjectsFromArray:viewController.comments];
                     for (NSDictionary* dict in arr02) {
                         [dataArr addObject:[JWDramaCommentModel objectWithDict:dict]];
                         viewController.comments = dataArr;
                         [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:dataArr.count - 1 inSection:0]]withRowAnimation:UITableViewRowAnimationFade];
                         
                     }
                     [tableView.mj_footer endRefreshing];
                 }
                 return HTML;
             }
             failure:^(NSError* _Nonnull error){
                 [tableView.mj_header endRefreshing];
             }];
}

@end
