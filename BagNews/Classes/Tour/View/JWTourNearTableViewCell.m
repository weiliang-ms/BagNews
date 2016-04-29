//
//  JWTourNearTableViewCell.m
//  BagNews
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourNearTableViewCell.h"
#import "JWTourNearModel.h"
@interface JWTourNearTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;

@end
@implementation JWTourNearTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(JWTourNearModel *)model
{
    _model = model;
    [self.imgMain sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
    self.labelTitle.text = model.name;
    self.labelDistance.text = [NSString stringWithFormat:@"距我%.2fkm / %ld人去过",model.distance * 100,model.visited_count];
    self.labelDescription.text = model.address;
}

@end
