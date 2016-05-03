//
//  JWDramaChirldVM.h
//  BagNews
//
//  Created by 微凉 on 16/5/2.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWViewModel.h"
@class JWDramaDetailChild;
@interface JWDramaChirldVM : NSObject

+ (void)getVideoInfo:(NSString *)url
            CallBack:(void(^)(NSArray *arr))callBack;
+ (void)getDramaCommentsData:(NSString *)url TableView:(UITableView *)tableView ViewController:(JWDramaDetailChild *)viewController;
+ (void)getMoreDramaCommentsData:(NSString *)url TableView:(UITableView *)tableView ViewController:(JWDramaDetailChild *)viewController;
@end
