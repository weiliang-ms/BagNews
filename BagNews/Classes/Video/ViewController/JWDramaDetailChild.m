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
#import "JWDramaCommentCell.h"
@interface JWDramaDetailChild ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UILabel *playLabel;

@property(nonatomic,retain)UILabel *titleLabel;

@property(nonatomic,retain)UILabel *introLabel;

@property(nonatomic,retain)NSArray *arr;

@property(nonatomic,strong)UITableView *tableView;

@end
static NSString *const mp4_url = @"http://www.bilibilijj.com/Api/AvToCid/%@";
static NSString *const comment_url = @"http://api.bilibili.com/feedback?type=jsonp&ver=3&callback=jQuery172019889523880556226_1446769749937&mode=arc&_=1446769758188&page=%ld&aid=%@&pagesize=20&";
@implementation JWDramaDetailChild
- (NSArray *)arr
{
    if (!_arr) {
        _arr = [NSArray array];
    }
    
    return _arr;
}
- (void)loadView
{
    [super loadView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JWDramaCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([JWDramaCommentCell class])];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAVPlayerUrl];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.playLabel];
    [self.view addSubview:self.introLabel];
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    
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

#pragma mark - lazyLoading
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
        _introLabel = [[UILabel alloc] init];
        _introLabel.numberOfLines = 0;
        _introLabel.frame =  CGRectMake(15, CGRectGetMaxY(self.playLabel.frame) + 10, SCREENWIDTH - 15, [self.model.descriptions boundingRectWithSize:CGSizeMake(SCREENWIDTH - 15, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height);
        _introLabel.text = self.model.descriptions;
        _introLabel.font = [UIFont systemFontOfSize:14];
    }
    
   return  _introLabel;
}
- (NSArray *)comments
{
    if (!_comments) {
        _comments = [NSArray array];
    }
    
    return _comments;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(2 * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - 306) style:0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(getRefreshData)];
        _tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    }
    
    return _tableView;
}
#pragma - mark 播放视频
- (void)labelClick:(UITapGestureRecognizer *)tap
{
    JWAVPlayerViewController *av = [[JWAVPlayerViewController alloc] init];
    JWDramaChirldModel *model = [self.arr firstObject];
    av.url = model.Mp4Url;
    av.danmaku = model.CID;
    [self presentViewController:av animated:YES completion:nil];
}
// 刷新评论内容
- (void)getRefreshData
{;
    NSInteger index = 1;
    [JWDramaChirldVM getDramaCommentsData:[NSString stringWithFormat:comment_url,(long)index,self.model.aid] TableView:self.tableView ViewController:self];
}

- (void)getMoreData
{
    static NSInteger index = 1;
    index++;
    [JWDramaChirldVM getMoreDramaCommentsData:[NSString stringWithFormat:comment_url,(long)index,self.model.aid] TableView:self.tableView ViewController:self];
}
#pragma mark - <UITableView>代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.comments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JWDramaCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JWDramaCommentCell class]) forIndexPath:indexPath];
    cell.model = self.comments[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;
}
@end
