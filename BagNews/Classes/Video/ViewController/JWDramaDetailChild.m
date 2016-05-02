//
//  JWDramaDetailChild.m
//  BagNews
//
//  Created by 微凉 on 16/5/2.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaDetailChild.h"
#import "JWDaramHeadModel.h"
#import "JWAVPlayerViewController.h"
#import "JWDramaChirldModel.h"
#import "JWDramaChirldVM.h"
@interface JWDramaDetailChild ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UILabel *playLabel;

@property(nonatomic,retain)UILabel *titleLabel;

@property(nonatomic,retain)UILabel *introLabel;

@property(nonatomic,retain)NSArray *arr;
@end
static NSString *const mp4_url = @"http://www.bilibilijj.com/Api/AvToCid/%@";
@implementation JWDramaDetailChild
- (NSArray *)arr
{
    if (!_arr) {
        _arr = [NSArray array];
    }
    
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAVPlayerUrl];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.playLabel];
    [self.view addSubview:self.introLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)getAVPlayerUrl
{
    [JWDramaChirldVM getVideoInfo:[NSString stringWithFormat:mp4_url,self.model.aid] CallBack:^(NSArray *arr) {
            self.arr = arr;
        
    }];
}

// lazyLoading
- (UILabel *)playLabel
{
    if (!_playLabel) {
        
        _playLabel = [[UILabel alloc] init];
        _playLabel.textColor = [UIColor redColor];
        _playLabel.numberOfLines = 0;
        _playLabel.text = [NSString stringWithFormat:@"\t\t%@",self.model.title];
        _playLabel.backgroundColor = [UIColor orangeColor];
        _playLabel.alpha = 0.7;
        _playLabel.layer.cornerRadius = 4;
        _playLabel.clipsToBounds = YES;
        _playLabel.font = [UIFont systemFontOfSize:14];
        _playLabel.userInteractionEnabled = YES;
        _playLabel.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame) + 10, SCREENWIDTH / 3, [self.model.title boundingRectWithSize:CGSizeMake(SCREENWIDTH / 3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height);
        [_playLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    
    return _playLabel;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH / 5, 30)];
        _titleLabel.text = @"播放列表";
        _titleLabel.textAlignment = 2;
    }
    return _titleLabel;
}

- (UILabel *)introLabel
{
    if (!_introLabel) {
        _introLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.playLabel.frame) + 10, SCREENWIDTH - 15, 30)];
        _introLabel.text = self.model.descriptions;
        _introLabel.font = [UIFont systemFontOfSize:14];
    }
    
   return  _introLabel;
}
- (void)labelClick:(UITapGestureRecognizer *)tap
{
    JWAVPlayerViewController *av = [[JWAVPlayerViewController alloc] init];
    JWDramaChirldModel *model = [self.arr firstObject];
    av.url = model.Mp4Url;
    [self presentViewController:av animated:YES completion:nil];
}
@end
