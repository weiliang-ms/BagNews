//
//  JWNavigationController.m
//  BagNews
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "JWNavigationController.h"

//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKExtension/SSEShareHelper.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
//#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
//#import <ShareSDK/ShareSDK+Base.h>
//
//
//
//
//#import "ShareTool.h"
//
//#import <ShareSDKExtension/ShareSDK+Extension.h>



@interface JWNavigationController ()




@end

@implementation JWNavigationController

// 只初始化一次
+ (void)initialize
{
    // 设置项目中item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // Normal
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = RGBColor(123, 123, 123);
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


/*  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 此时push进来的viewController是第二个子控制器
        // 自动隐藏tabbar
        viewController.hidesBottomBarWhenPushed = NO;
        
        // 定义leftBarButtonItem
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTargat:self action:@selector(back) image:@"fanhui" highImage:@"fanhui"];
        
//        // 定义rightBarButtonItem
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTargat:self action:@selector(share) image:@"fenxianghui" highImage:@"fenxianghui"];
        
        
    }
    // 调用父类pushViewController，self.viewControllers数组添加对象viewController
    [super pushViewController:viewController animated:animated];
    

}
- (void)back
{
    // 这里要用self，不能用self.navigationViewController，因为self本身就是导航控制器对象，self.navigationViewController是nil
    [self popViewControllerAnimated:YES];
}



@end
