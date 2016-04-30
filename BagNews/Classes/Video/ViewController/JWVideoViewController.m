//
//  JWVideoViewController.m
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWVideoViewController.h"
#import "JWWaterFallLayout.h"
#import "JWDramaTableViewCell.h"
#import "JWDramaVM.h"
#import "JWDramaModel.h"
#import "JWDramaHeader.h"
static NSString *const url = @"http://app.bilibili.com/bangumi/timeline_v2";
@interface JWVideoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,JWShopFlowLayoutDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;



@end

@implementation JWVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    [self.collectionView.mj_header beginRefreshing];
}
#pragma mark - 下拉请求数据
- (void)refresh
{
    [JWDramaVM getNewsWithUrl:url CollectionView:self.collectionView ViewController:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma dataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JWDramaTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JWDramaTableViewCell class]) forIndexPath:indexPath];
    cell.model = self.models[indexPath.item];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
#pragma delegate 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGFloat)shopFlowLayoutWithHight:(JWWaterFallLayout *)flowLayout layoutWitdh:(CGFloat)cellW forIndex:(NSIndexPath *)indexP
{
    JWDramaModel *model = self.models[indexP.row];
    
    return  1.1 * cellW + [model.title boundingRectWithSize:CGSizeMake(cellW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
}
// lazyLoading
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        JWWaterFallLayout *layout = [[JWWaterFallLayout alloc] init];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JWDramaTableViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([JWDramaTableViewCell class])];
        [_collectionView registerClass:[JWDramaHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([JWDramaHeader class])];
        _collectionView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    }
    
    return _collectionView;
}
- (NSArray *)models
{
    if (!_models) {
        _models = [NSArray array];
    }
    return _models;
}
- (NSArray *)heads
{
    if (!_heads) {
        _heads = [NSArray array];
    }
    return _heads;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {

       self.header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([JWDramaHeader class]) forIndexPath:indexPath];
        reusableView = self.header;
    }
    
    return reusableView;
}
@end
