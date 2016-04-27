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

+ (void)selectedCellTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath ViewController:(UIViewController *)viewController Link:(NSString *)link;
+ (void)getMoreData:(NSString *)url ViewController:(UIViewController *)viewController TableView:(UITableView *)tableView DataArr:(NSMutableArray *)dataArr;
+ (void)getNewsData:(NSString *)url ViewController:(UIViewController *)viewController TableView:(UITableView *)tableView;
@end
