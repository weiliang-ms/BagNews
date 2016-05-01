//
//  JWAVPlayerViewController.m
//  BagNews
//
//  Created by 微凉 on 16/5/1.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height

@interface JWAVPlayerViewController ()

@property(nonatomic,strong)AVPlayer *player; // 播放属性
@property(nonatomic,strong)AVPlayerItem *playerItem; // 播放属性
@property(nonatomic,strong)UISlider *slider; // 进度条
@property(nonatomic,strong)UILabel *currentTimeLabel; // 当前播放时间
@property(nonatomic,strong)UILabel *systemTimeLabel; // 系统时间
@property(nonatomic,strong)UIView *backView; // 上面一层Viewd
@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,assign)CGFloat systemVolume;
@property(nonatomic,strong)UISlider *volumeViewSlider;
@property(nonatomic,strong)UIActivityIndicatorView *activity; // 系统菊花
@property(nonatomic,strong)UIProgressView *progress; // 缓冲条
@property(nonatomic,strong)UIView *topView;
@end

@implementation JWAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.player play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 懒加载
- (AVPlayer *)player
{
    if (!_player) {
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.url]];
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
        playerLayer.videoGravity = AVLayerVideoGravityResize;
        [self.view.layer addSublayer:playerLayer];
    }
    return _player;
}
@end
