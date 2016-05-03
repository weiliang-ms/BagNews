//
//  JWDaramDetailViewController.m
//  BagNews
//
//  Created by 微凉 on 16/5/1.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDaramDetailViewController.h"
#import "JWDramaBar.h"
#import "JWDaramHeadModel.h"
#import "JWDramaDetailChild.h"
@interface JWDaramDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgCover;
@property (weak, nonatomic) IBOutlet UIButton *upName;
@property (weak, nonatomic) IBOutlet UILabel *dramaInfo;
@property (weak, nonatomic) IBOutlet UILabel *dramatitle;
@property (strong, nonatomic)JWDramaBar *dramaBar;
@property(nonatomic,strong)UIScrollView *mainScr;

@end

@implementation JWDaramDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:[[JWDramaDetailChild alloc] init]];
    [self.view addSubview:self.dramaBar];
    [self.view addSubview:self.mainScr];
    [self setDataWithModel];
    
}
// 配置相关数据
- (void)setDataWithModel
{
    [self.imgCover sd_setImageWithURL:[NSURL URLWithString:self.model.pic] placeholderImage:[UIImage imageNamed:@"smallPlayHolder"]];
    self.dramatitle.text = self.model.title;
    [self.upName setTitle:[NSString stringWithFormat:@"UP主:%@",self.model.author] forState:0];
    NSString *playCount = self.model.play > 10000 ? [NSString stringWithFormat:@"%0.2f次播放",(double)self.model.play / 10000]:[NSString stringWithFormat:@"%ld次播放",(long)self.model.play ];
    NSString *commentCount = self.model.video_review > 10000 ? [NSString stringWithFormat:@"%0.2f条弹幕",(double)self.model.video_review / 10000]:[NSString stringWithFormat:@"%ld条弹幕",(long)self.model.video_review];
    self.dramaInfo.text = [playCount stringByAppendingString:[NSString stringWithFormat:@"\t\t%@",commentCount]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (JWDramaBar *)dramaBar
{
    if (!_dramaBar) {
        _dramaBar= [[JWDramaBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dramaInfo.frame), SCREENWIDTH, 48)];
        WEAK(ws);
        _dramaBar.clickBtn = ^(NSInteger index)
        {
            __strong typeof(ws)strongSelf = ws;
            strongSelf.mainScr.contentOffset = CGPointMake(SCREENWIDTH * (index - 1), 0);
        };
    }
    
    return _dramaBar;
}
- (IBAction)upName:(id)sender {
}
- (UIScrollView *)mainScr
{
    if (!_mainScr) {
        _mainScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dramaBar.frame), SCREENWIDTH, SCREENHEIGHT - 306)];
        _mainScr.backgroundColor = [UIColor redColor];
        _mainScr.delegate = self;
        _mainScr.bounces = NO;
        _mainScr.pagingEnabled = YES;
        _mainScr.contentSize = CGSizeMake(SCREENWIDTH * 3, 0);
        JWDramaDetailChild *vc = [self.childViewControllers firstObject];
        vc.model = self.model;
        vc.view.frame = CGRectMake(0, 0, _mainScr.width * 3, _mainScr.height);
        [_mainScr addSubview:vc.view];
    }
    
    
    return _mainScr;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.dramaBar.scrLable.transform = CGAffineTransformMakeTranslation(90 * scrollView.contentOffset.x / SCREENWIDTH, 0);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

     NSUInteger tagNum = (scrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width * 0.5) / [UIScreen mainScreen].bounds.size.width + 1;
    [self.dramaBar changeColor:tagNum];
}

@end
