//
//  JWTourBigCell.m
//  BagNews
//
//  Created by 微凉 on 16/4/27.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourBigCell.h"
#import "JWTourCustomModel.h"
@interface JWTourBigCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@property (weak, nonatomic) IBOutlet UILabel *labeltitle;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *labelUser;

@end
@implementation JWTourBigCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(JWTourCustomModel *)model
{
    _model = model;
    [self.imgMain sd_setImageWithURL:[NSURL URLWithString:model.cover_image] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
    self.labeltitle.text = model.name;
    self.labelDate.text = [model.first_day stringByAppendingString:[NSString stringWithFormat:@"   %ld天",(long)model.day_count]];
    self.labelLocation.text = model.popular_place_str;
    self.imgUser.layer.cornerRadius = 18;
    self.imgUser.layer.masksToBounds = YES;
    [self.imgUser sd_setImageWithURL:[NSURL URLWithString:model.user[@"avatar_m"]] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
    self.labelUser.text = model.user[@"name"];

}
@end
