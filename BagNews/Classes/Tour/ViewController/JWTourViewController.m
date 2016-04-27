//
//  JWTourViewController.m
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourViewController.h"
//#import "JWCarouselFigureCollectionView.h"
#import "JWTourViewModel.h"
#import "JWTourModel.h"
#import "JWTourHeadModel.h"
@interface JWTourViewController ()

@property(nonatomic,copy)NSMutableArray *dataArr;
//@property(strong,nonatomic)JWCarouselFigureCollectionView *head;

@end

@implementation JWTourViewController
// lazyLoading
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNewsData
{
    [JWTourViewModel getData:@"http://api.breadtrip.com/v2/index/" CallBackBlock:^(NSMutableArray *dataArr) {
//        self.head.picUrlArr = dataArr;
        self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.width, 300 *self.view.width / SCREENWIDTH);
        [self.tableView reloadData];
    }];
}
@end
