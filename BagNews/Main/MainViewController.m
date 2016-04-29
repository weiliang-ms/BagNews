//
//  MainViewController.m
//  BagNews
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MainViewController.h"
#import "JWNewsViewController.h"
#import "JWTourViewController.h"
#import "JWVideoViewController.h"
#import "JWMineViewController.h"
#import "JWNavigationController.h"
@interface MainViewController ()
//@property(retain,nonatomic)UIImageView *img;

@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.img removeFromSuperview];
    //    self.img.hidden = YES;
    // 添加子控制器
    [self addChildVc:[[JWNewsViewController alloc] init] title:@"新闻" image:@"xinwenputong.png" selectedImage:@"xinwenxuanzhong.png"];
    [self addChildVc:[[JWTourViewController alloc] init] title:@"旅行" image:@"iconfont-erciyuan-2" selectedImage:@"iconfont-erciyuan-2"];
    [self addChildVc:[[JWVideoViewController alloc] init] title:@"视频" image:@"iconfont-dibushiting" selectedImage:@"iconfont-dibushiting-2"];
    [self addChildVc:[[JWMineViewController alloc] init] title:@"我的" image:@"iconfont-duanzi" selectedImage:@"iconfont-duanzi-2"];
  
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBColor(123, 123, 123)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBColor(244, 198, 0)} forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
    // 为子控制器包装导航控制器
    JWNavigationController *navigationVc = [[JWNavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];
}

@end
