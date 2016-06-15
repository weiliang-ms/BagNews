//
//  JWTourNearMainViewController.m
//  BagNews
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourNearMainViewController.h"
#import "JWTourNearTop.h"
#import <CoreLocation/CoreLocation.h>
#import "JWTourNearViewController.h"
#import "TourNearUrlsHeader.h"
@interface JWTourNearMainViewController ()<CLLocationManagerDelegate,UIScrollViewDelegate>

@property(strong,nonatomic)JWTourNearTop *topView;

@property(nonatomic,retain)CLLocationManager *locationManager;

@property(strong,nonatomic)UIScrollView *mainScr;

@property(assign,nonatomic)CLLocationCoordinate2D coordinate;

@property(nonatomic,copy)NSArray *urls;
@end

@implementation JWTourNearMainViewController
- (NSArray *)urls
{
    if (!_urls) {
        _urls = [NSArray arrayWithObjects:ALL,SPOT,HOTELU,RESTAURANT,ENTERTAINMENT,SHOPPING, nil];
    }
    return _urls;
}
/*本模块设计内容：运行时字典转模型 地图定位*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.topView];
    [self.view addSubview:self.mainScr];
    [self getCurrentPosition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 懒加载
- (JWTourNearTop *)topView
{
    if (!_topView) {
        _topView = [[JWTourNearTop alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30) Arr:@[@"全部", @"景点", @"住宿", @"餐厅", @"休闲娱乐", @"购物"]];
        WEAK(ws);
        _topView.itemClick = ^(NSInteger index)
        {
            __strong typeof(ws)strongSelf = ws;
            strongSelf.mainScr.contentOffset = CGPointMake(index * SCREENWIDTH, 0);
        };
#pragma - mark 添加子控制器
        for (int i = 0; i < 6; i++) {
            JWTourNearViewController *near = [[JWTourNearViewController alloc] init];
            [self addChildViewController:near];
        }
        
    }
    return _topView;
}
- (UIScrollView *)mainScr
{
    if (!_mainScr) {
        _mainScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, SCREENWIDTH, SCREENHEIGHT - 138)];
        _mainScr.contentSize = CGSizeMake(self.childViewControllers.count * SCREENWIDTH, 0);
        _mainScr.bounces = NO;
        _mainScr.delegate = self;
        _mainScr.showsHorizontalScrollIndicator = NO;
        _mainScr.showsVerticalScrollIndicator = YES;
        _mainScr.pagingEnabled = YES;
        JWTourNearViewController *viewController = [self.childViewControllers firstObject];
        viewController.url = [self.urls firstObject];
        viewController.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 108);
//        viewController.view.backgroundColor = [UIColor orangeColor];
        [_mainScr addSubview:viewController.view];

    }
    
    return _mainScr;
}
#pragma - 开启定位
- (void)getCurrentPosition
{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate  = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位失败，启动默认城市" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 获取当前位置
    CLLocation *currentLocation = [locations lastObject];
//    self.location = currentLocation;
    self.coordinate = currentLocation.coordinate;
    [manager stopUpdatingLocation];

}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    _coordinate = coordinate;
//    double latitude = coordinate.latitude;// 纬度
//    double longitude = coordinate.longitude;// 经度
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshLocation" object:nil userInfo:@{@"latitude":@"latitude",@"longitude":@"longitude"}];
}
#pragma - mark 上随下动同时赋值给上面Scr
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / SCREENWIDTH;
    JWTourNearViewController *viewController = self.childViewControllers[index];
    if (viewController.view.superview)
    {
        
    }else
    {
        viewController.view.frame = CGRectMake(index * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - 138);
        viewController.url = [self.urls objectAtIndex:index];
//        viewController.view.backgroundColor = [UIColor orangeColor];
        [self.mainScr addSubview:viewController.view];
    }
    self.topView.index = index;
}
@end
