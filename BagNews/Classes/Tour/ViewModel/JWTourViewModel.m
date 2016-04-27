//
//  JWTourViewModel.m
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTourViewModel.h"
#import "JWTourModel.h"
#import "JWTourDayly.h"
#import "JWTourHeadModel.h"
#import "JWTourCustomModel.h"
@implementation JWTourViewModel
+ (void)getData:(NSString *)url CallBackBlock:(CallBackBlock)callBackBlock
{
    // 重写父类方法

    __block NSMutableArray *dataArr = [NSMutableArray array];
    [JWNetTool getWithURL:url Parameter:nil Progress:^(NSProgress *progress) {
        
        
    } Success:^(id result) {
        NSDictionary *dataDic = [result objectForKey:@"data"];
        NSArray *arr = [dataDic objectForKey:@"elements"];
        NSDictionary *dicData = [arr firstObject];
        NSArray *arrData = [dicData objectForKey:@"data"];
        for (NSDictionary *temp in [arrData firstObject]) {
            JWTourHeadModel *model= [JWTourHeadModel modelWithDic:temp];
            [dataArr addObject:model.image_url];
        }
        callBackBlock(dataArr);
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    } HttpHeader:nil ResponseType:ResponseTypeJSON];
}

@end
