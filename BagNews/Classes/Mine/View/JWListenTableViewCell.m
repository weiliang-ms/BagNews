//
//  JWListenTableViewCell.m
//  BagNews
//
//  Created by 微凉 on 16/6/14.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWListenTableViewCell.h"
#import "JWTools.h"
#import "JWListenModel.h"
#define SPACE 10
#define LISTENCELLHEIGHT 100
@implementation JWListenTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI{
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(SPACE, SPACE, SCREENWIDTH/3, LISTENCELLHEIGHT - 2*SPACE)];
    [self.contentView addSubview:self.titleImage];
    
    self.titleLable = [JWTools titleLableWithFrame:CGRectMake(2*SPACE + SCREENWIDTH/3, SPACE, SCREENWIDTH*0.6, LISTENCELLHEIGHT*2/3)];
    self.titleLable.font = [UIFont systemFontOfSize:18];
    self.titleLable.numberOfLines = 0;
    [self.contentView addSubview:self.titleLable];
    
    self.fileSizeLable = [[UILabel alloc]initWithFrame:CGRectMake(2*SPACE + SCREENWIDTH / 3, LISTENCELLHEIGHT*2/3+ SPACE, 100, LISTENCELLHEIGHT / 5)];
    [self.contentView addSubview:self.fileSizeLable];
    
    self.timeLable = [JWTools timeLableWithFrame:CGRectMake(SCREENWIDTH*3/4, LISTENCELLHEIGHT*2/3+ SPACE, SCREENWIDTH/5, LISTENCELLHEIGHT/5)];
    [self.contentView addSubview:self.timeLable];
}


- (void)setModel:(JWListenModel *)model{
    NSData *jsonData = [model.smeta dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *imageUrl = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    CGFloat size = [model.post_size doubleValue];
    size = size / 1024 / 1024;
    NSMutableAttributedString *sizeStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"大小%.2fM",size]];
    [sizeStr addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithRed:0.237 green:0.839 blue:0.861 alpha:1.000] range:NSMakeRange(0, 2)];
    [sizeStr addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithWhite:0.606 alpha:1.000] range:NSMakeRange(2, sizeStr.length-2)];
    [sizeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, sizeStr.length)];
    [sizeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, sizeStr.length)];
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:imageUrl[@"thumb"]] placeholderImage:nil];
    self.titleLable.text = model.post_title;
    self.fileSizeLable.attributedText = sizeStr;
    self.timeLable.text = [model.post_date substringToIndex:10];
}

@end
