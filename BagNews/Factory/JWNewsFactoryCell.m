//
//  JWNewsFactoryCell.m
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNewsFactoryCell.h"
#import "JWModel.h"
#import "JWNewsModel.h"
#import "UITableViewCell+JW.h"
@implementation JWNewsFactoryCell
+ (UITableViewCell *)creatTableViewCellWithModel:(JWNewsModel *)model TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    return [self creatTableViewCellWithModel:model TableView:tableView IndexPath:indexPath CellType:[self cellTypeWithModel:model]];
    
}
+ (UITableViewCell *)creatTableViewCellWithModel:(JWNewsModel *)model TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath CellType:(CellType)type
{
    UITableViewCell *cell = nil;
    switch (type) {
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"JWNewsOneImageCell"];
            break;
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"JWNewsBigImageCell"];

            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"JWNewsThreeImagesCell"];
            break;
        default:
            break;
    }
    
    
    [cell setCellWithModel:model];
    return cell;
}
+(CellType)cellTypeWithModel:(JWNewsModel *)model
{
    if (![model.category isEqualToString:@"hdpic"]) {
        if ([model.category isEqualToString:@"cms"]) {
            return NewsOneImageCell;
        }else{
            
            return NewsOneBigImageCell;
        }
    }
    
    return NewsThreeImageCell;
}
+ (CGFloat )cellForRowHeightWithModel:(JWNewsModel *)model TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    return [self cellForRowHeightWithModel:model TableView:tableView IndexPath:indexPath Type:[self cellTypeWithModel:model]];
}
+ (CGFloat)cellForRowHeightWithModel:(JWNewsModel *)model TableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Type:(CellType)type
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (type) {
        case 0:
            return 220;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return 150;
            break;
            
        default:
            break;
    }
}
@end
