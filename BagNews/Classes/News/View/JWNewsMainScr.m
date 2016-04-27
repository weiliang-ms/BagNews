//
//  JWNewsMainScr.m
//  BagNews
//
//  Created by 微凉 on 16/4/23.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNewsMainScr.h"
#import "JWNewsTableViewController.h"
@interface JWNewsMainScr ()<UIScrollViewDelegate>

@end
@implementation JWNewsMainScr
- (instancetype)initWithFrame:(CGRect)frame Arr:(NSArray*)array ViewController:(UIViewController *)viewController
{
    self = [super initWithFrame:frame];
    if (self
        ) {
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.contentSize = CGSizeMake(array.count * SCREENWIDTH, SCREENHEIGHT - 94);
        self.delegate  =  (id)viewController;
        self.showsHorizontalScrollIndicator = NO;
        UIViewController *vc = [viewController.childViewControllers firstObject];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 94);
        [self addSubview:vc.view];
//        for (int i = 0; i < array.count; i++) {
//            JWNewsTableViewController *temp = [viewController.childViewControllers objectAtIndex:i];
//            temp.view.frame = CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - 94);
//            temp.tableView.backgroundColor = RandomColor;
//            temp.url = [NSString stringWithFormat:URL,[array objectAtIndex:i][@"url"]];
//            NSLog(@"%@",temp.url);
//            [self addSubview:temp.view];
//        }
       
        
    }
    
    return self;
}

@end
