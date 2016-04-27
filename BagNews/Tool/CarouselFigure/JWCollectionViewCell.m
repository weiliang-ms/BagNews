//
//  JWCollectionViewCell.m
//  JWCarouselFigureView
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface JWCollectionViewCell ()

//@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
//@property (weak, nonatomic) IBOutlet UILabel *picNum;
//@property (weak, nonatomic) IBOutlet UILabel *lableTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lableTitle;
@property (weak, nonatomic) IBOutlet UILabel *picNum;

@end
@implementation JWCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setUrl:(NSString *)url
{
    _url = url;
    [self.imgMain sd_setImageWithURL:[NSURL URLWithString:_url]];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    if ([_title isEqualToString:@""]) {
        [self.lableTitle removeFromSuperview];
    } else {
        self.lableTitle.text = _title;
        self.lableTitle.textColor = [UIColor redColor];
    }
}

- (void)setNum:(NSString *)num
{
    _num = num;
    self.picNum.text = _num;
    self.picNum.textColor = [UIColor redColor];
    self.picNum.textAlignment = NSTextAlignmentRight;
}
@end
