//
//  JWDramaShopController.m
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaShopController.h"
#import "JWDramaModel.h"
@interface JWDramaShopController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *play;
@property (weak, nonatomic) IBOutlet UILabel *danmu;
@property (nonatomic, assign) CGFloat lastY;
@property (weak, nonatomic) IBOutlet UILabel *timeLink;

@end

@implementation JWDramaShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
