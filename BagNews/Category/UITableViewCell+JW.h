//
//  UITableViewCell+JW.h
//  BagNews
//
//  Created by 微凉 on 16/4/26.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWNewsModel;
@interface UITableViewCell (JW)
- (void)setCellWithModel:(JWNewsModel *)model;
- (void)changeCellTextColor;
@end
