//
//  JWItem.h
//  BagNews
//
//  Created by 微凉 on 16/4/22.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    top = 0,
    bottom,
} itemLocation;
typedef enum{
    commonState,
    longPressState,
} itemState;
typedef void(^ClickBlock)();
@interface JWItem : UILabel
@property(copy,nonatomic)ClickBlock clickBlock;

@property(assign,nonatomic)itemLocation location;

@property(copy,nonatomic)NSDictionary *dic;

@property(nonatomic,strong)UIImageView *deleteImg;// 删除图标

@property(assign,nonatomic)itemState state;

@end
