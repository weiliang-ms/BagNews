//
//  JWDramaCommentCell.m
//  BagNews
//
//  Created by 微凉 on 16/5/3.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaCommentCell.h"
#import "JWDramaCommentModel.h"

@interface JWDramaCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *labelUser;
@property (weak, nonatomic) IBOutlet UILabel *labelNum;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelComments;

@end
@implementation JWDramaCommentCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(JWDramaCommentModel *)model
{
    _model = model;
    [self.imgUser sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
    self.labelUser.text = model.nick;
    self.labelDate.text = [model.create_at substringWithRange:NSMakeRange(0, 9)];
    self.labelNum.text = [NSString stringWithFormat:@"#\t%ld",(long)model.lv];
    CGRect frame = self.labelComments.frame;
    frame.size.height = [model.msg boundingRectWithSize:CGSizeMake(frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
    self.labelComments.frame = frame;
    self.rowH = CGRectGetMaxY(self.labelComments.frame);
    self.labelComments.text = model.msg;
}
@end
