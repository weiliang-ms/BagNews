//
//  JWNewsBigImageCell.m
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNewsBigImageCell.h"
#import "JWNewsModel.h"
@interface JWNewsBigImageCell ()

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imgMain;

@end
@implementation JWNewsBigImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellWithModel:(JWNewsModel *)model
{
    
    [self.imgMain sd_setImageWithURL:[NSURL URLWithString:model.kpic] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
    self.labelTitle.text = model.title;
    
}
@end
