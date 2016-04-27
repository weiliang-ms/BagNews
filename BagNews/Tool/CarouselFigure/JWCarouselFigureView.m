//
//  JWCarouselFigureView.m
//  JWCarouselFigureView
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWCarouselFigureView.h"
#import "JWCollectionViewCell.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kSEC 3
@interface JWCarouselFigureView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(assign,nonatomic,getter=isStart)BOOL start;// 判断定时器状态 防止多次创建

@property(weak,nonatomic)NSTimer *timer;



@end
@implementation JWCarouselFigureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#pragma - mark collectioView初始化
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView = collectionView;
        [collectionView registerNib:[UINib nibWithNibName:@"JWCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JWCollectionViewCell"];
        // 第一个出现的是第二个item也就是数据的第一条数据
        collectionView.contentOffset = CGPointMake(frame.size.width, 0);
        [self addSubview:collectionView];
        // 初始化定时器
        [self setUpTimer];
    }
    
    return self;
}
#pragma - collectionView协议方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JWCollectionViewCell" forIndexPath:indexPath];
    
    return [self setDataForCell:cell IndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pics.count + 2;
}
#pragma - mark cell赋值
- (UICollectionViewCell *)setDataForCell:(JWCollectionViewCell *)cell IndexPath:(NSIndexPath *)indexPath
{
#pragma - mark 判断是第几个cell 第一个cell赋数组最后一个数据,最后一个cell赋值数组第一个数据
    NSInteger count = self.pics.count;
    if (indexPath.item == 0) {
        cell.url = [self.pics lastObject];
        cell.title = self.titles.count > 0 ? [self.titles lastObject]:nil;
//        cell.color = self.color ? self.color:[UIColor redColor];
        cell.num = [NSString stringWithFormat:@"%ld/%ld",(unsigned long)self.pics.count,(unsigned long)self.pics.count];
        
        
    } else if(indexPath.item == count + 1){
        cell.url = [self.pics firstObject];
        cell.title = self.titles.count > 0 ? [self.titles firstObject]:nil;
//        cell.color = self.color ? self.color:[UIColor redColor];
        cell.num = [NSString stringWithFormat:@"1/%ld",(unsigned long)self.pics.count];
    } else
    {
        cell.url = [self.pics objectAtIndex:indexPath.item - 1];
        cell.title = self.titles.count > 0 ? [self.titles objectAtIndex:indexPath.item - 1]:nil;
//        cell.color = self.color ? self.color:[UIColor redColor];
        cell.num = [NSString stringWithFormat:@"%ld/%ld",(long)indexPath.item,(unsigned long)self.pics.count];
    }
    cell.color = self.color ? self.color:[UIColor redColor];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / kWIDTH;
#pragma - 手动滑动时候判断滑到第几张 执行相应的跳转
    if (index == self.pics.count + 1) {
        self.collectionView.contentOffset = CGPointMake(kWIDTH * 1, 0);
    } else if(index == 0){
        self.collectionView.contentOffset = CGPointMake(kWIDTH * self.pics.count, 0);
    }
    
}
#pragma mark - 定时器创建方法
- (void)setUpTimer
{
    if (!_start) {
        
        NSInteger sec = self.sec > 0 ? self.sec : kSEC;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(timerActionMethod) userInfo:nil repeats:YES];

        
        
        _start = !_start;
    }
}
// 定时器关联方法
- (void)timerActionMethod
{
    NSInteger index = self.collectionView.contentOffset.x / kWIDTH;
    NSInteger pointX = 0;
    if (index == self.pics.count + 1) {
        
    } else{
        pointX = (index + 1) * kWIDTH;
    }
    
    self.collectionView.contentOffset = CGPointMake(pointX, 0);
}

#pragma - mark 拖拽开始 关闭定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.timer invalidate];
    self.start = NO;
}

#pragma - mark 拖拽结束后 重新创建定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger sec = self.secNew > 0 ? self.sec : 2 * kSEC;
    [self performSelector:@selector(setUpTimer) withObject:nil afterDelay:sec];
}
#pragma - 点击回调
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.item);
    if (self.CallBack) {
        if (indexPath.item == 0) {
            self.CallBack(self.pics.count - 1);
        } else if(indexPath.item == self.pics.count + 1){
            self.CallBack(0);
        }else
        {
            self.CallBack(indexPath.item - 1);
        }
    }
}
@end

