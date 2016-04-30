//
//  JWDramaHeadCell.m
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaHeadCell.h"
#import "JWDaramHeadModel.h"
@interface JWDramaHeadCell ()
@property (weak, nonatomic) IBOutlet UILabel *lableTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgCover;

@end
@implementation JWDramaHeadCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(JWDaramHeadModel *)model
{
    _model = model;
    CGRect frame = self.lableTitle.frame;
    frame.size.height = [model.title boundingRectWithSize:CGSizeMake(frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size.height;
    self.lableTitle.frame = frame;
    [self.imgCover sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];

    self.lableTitle.text = model.title;
}
@end
