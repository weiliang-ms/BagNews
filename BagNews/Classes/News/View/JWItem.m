//
//  JWItem.m
//  BagNews
//
//  Created by 微凉 on 16/4/22.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWItem.h"

@implementation JWItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor blackColor];
        self.textAlignment = 1;
        self.userInteractionEnabled =  YES;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.deleteImg = [[UIImageView alloc] initWithFrame:CGRectMake(5,5, 12, 12)];
        self.deleteImg.image = [UIImage imageNamed:@"delete"];
        [self addSubview:self.deleteImg];
        self.deleteImg.hidden = YES;
    }
    
    return self;
}




@end
