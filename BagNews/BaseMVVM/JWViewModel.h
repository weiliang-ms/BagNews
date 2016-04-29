//
//  JWViewModel.h
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWNetTool.h"

@interface JWViewModel : NSObject
/*cell点击方法*/
+ (void)selectedCellTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath ViewController:(UIViewController *)viewController Link:(NSString *)link NS_REQUIRES_SUPER;
/*上拉加载*/
+ (void)getMoreData:(NSString *)url ViewController:(UIViewController *)viewController TableView:(UITableView *)tableView DataArr:(NSMutableArray *)dataArr NS_REQUIRES_SUPER;
/*下拉刷新*/
+ (void)getNewsData:(NSString *)url ViewController:(UIViewController *)viewController TableView:(UITableView *)tableView NS_REQUIRES_SUPER;
@end
