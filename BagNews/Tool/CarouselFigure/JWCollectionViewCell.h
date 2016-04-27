//
//  JWCollectionViewCell.h
//  JWCarouselFigureView
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWCollectionViewCell : UICollectionViewCell

@property(copy,nonatomic)NSString *url;

@property(copy,nonatomic)NSString *title;

@property(copy,nonatomic)NSString *num;

@property(retain,nonatomic)UIColor *color;
@end
