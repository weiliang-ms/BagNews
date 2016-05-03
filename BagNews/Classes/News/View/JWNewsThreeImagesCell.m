//
//  JWNewsThreeImagesCell.m
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNewsThreeImagesCell.h"
#import "JWNewsModel.h"
@interface JWNewsThreeImagesCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgCenter;
@property (weak, nonatomic) IBOutlet UILabel *lableComment;
@property (weak, nonatomic) IBOutlet UIImageView *imgRight;
@property (weak, nonatomic) IBOutlet UILabel *lableTitle;

@end
@implementation JWNewsThreeImagesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellWithModel:(JWNewsModel *)model
{
    NSDictionary *dic = model.pics;
    self.lableComment.text = [NSString stringWithFormat:@"%ld评论",(long)model.comment];
    self.lableTitle.text = model.title;
    NSArray *pics = [dic objectForKey:@"list"];
    if (pics.count > 2) {
        NSString *tempOne = [pics objectAtIndex:0][@"kpic"];
        NSString *tempTwo = [pics objectAtIndex:1][@"kpic"];
        NSString *tempThree = [pics objectAtIndex:2][@"kpic"];
        
        
        
        [self.imgLeft sd_setImageWithURL:[NSURL URLWithString:tempOne] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
        [self.imgCenter sd_setImageWithURL:[NSURL URLWithString:tempTwo] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
        [self.imgRight sd_setImageWithURL:[NSURL URLWithString:tempThree] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];

    }
}
@end
