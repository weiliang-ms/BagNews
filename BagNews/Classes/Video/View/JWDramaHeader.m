//
//  JWDramaHeader.m
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaHeader.h"
#import "JWCarouselFigureView.h"
#import "JWDaramHeadModel.h"
#import "LineLayout.h"
#import "JWDramaHeadCell.h"
#import "JWDramaVM.h"
@interface JWDramaHeader ()<UICollectionViewDelegate,UICollectionViewDataSource>



@end
@implementation JWDramaHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        UIImageView *imgTop = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        imgTop.image = [UIImage imageNamed:@"zajiadouzaikan"];
        [self addSubview:imgTop];
        UILabel *top = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 30)];
        top.text = @"大家都在看";
        top.font = [UIFont boldSystemFontOfSize:17];
        top.textColor = [UIColor orangeColor];
        [self addSubview:top];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(frame.size.height - 100, frame.size.height - 150);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, frame.size.height - 90) collectionViewLayout:layout];
        UIImageView *imgBottom = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.collectionView.frame) + 10, 30, 30)];
        imgBottom.image = [UIImage imageNamed:@"fanjutuijian"];
        [self addSubview:imgBottom];
        UILabel *bottom = [[UILabel alloc] initWithFrame:CGRectMake(50, imgBottom.y, 100, 30)];
        bottom.textColor = [UIColor orangeColor];
        bottom.text = @"番作推荐";
        [self addSubview:bottom];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.collectionView];
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JWDramaHeadCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([JWDramaHeadCell class])];
        [self addSubview:self.collectionView];
    
    }
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    [self.collectionView reloadData];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JWDramaHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JWDramaHeadCell class]) forIndexPath:indexPath];
    cell.model = self.arr[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JWDaramHeadModel *model = self.arr[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DaramHeadViewCellClick" object:model];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( M_PI, 0.7, 0.7, 0.8);

    cell.alpha = 0;
    cell.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1.2];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    [UIView commitAnimations];
}
@end
