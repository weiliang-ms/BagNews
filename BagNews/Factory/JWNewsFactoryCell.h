//
//  JWNewsFactoryCell.h
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTableViewCellClass.h"
@class JWNewsModel;
typedef NS_ENUM(NSUInteger, CellType) {
    
    NewsOneImageCell = 0,
    NewsOneBigImageCell,
    NewsThreeImageCell,
    
};
@interface JWNewsFactoryCell : NSObject
+ (UITableViewCell *)creatTableViewCellWithModel:(JWNewsModel *)model TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;
+ (CGFloat )cellForRowHeightWithModel:(JWNewsModel *)model TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;
@end
