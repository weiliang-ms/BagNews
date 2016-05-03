//
//  JWDramaCommentCell.h
//  BagNews
//
//  Created by 微凉 on 16/5/3.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWDramaCommentModel;
@interface JWDramaCommentCell : UITableViewCell
@property(nonatomic,strong)JWDramaCommentModel *model;
@property(assign,nonatomic)NSInteger rowH;

@end
