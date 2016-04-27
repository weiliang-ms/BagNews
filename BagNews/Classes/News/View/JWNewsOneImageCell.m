//
//  JWNewsOneImageCell.m
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNewsOneImageCell.h"
#import "JWNewsModel.h"
#import "UITableViewCell+JW.h"
@interface JWNewsOneImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelComment;

@end
@implementation JWNewsOneImageCell

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
    self.labelTitle.font = [UIFont boldSystemFontOfSize:17];
    self.labelDetail.text = [NSString stringWithFormat:@"       %@",model.intro];
    self.labelDetail.numberOfLines = 2;
    self.labelTitle.numberOfLines = 2;
    self.labelComment.text = [NSString stringWithFormat:@"%ld评论",model.comment];
    self.labelComment.textAlignment = 2;
    
}

- (void)changeCellTextColor
{
    self.labelTitle.textColor = [UIColor redColor];
    self.labelDetail.textColor = [UIColor redColor];
    self.labelComment.textColor = [UIColor redColor];
    [self layoutSubviews];
    
}
@end
