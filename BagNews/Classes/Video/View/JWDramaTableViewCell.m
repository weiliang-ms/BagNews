//
//  JWDramaTableViewCell.m
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaTableViewCell.h"
#import "JWDramaModel.h"
@interface JWDramaTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *imgCover;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end
@implementation JWDramaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(JWDramaModel *)model
{
    _model = model;
    [self.imgCover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
    self.labelTitle.text = model.title;
}
@end
