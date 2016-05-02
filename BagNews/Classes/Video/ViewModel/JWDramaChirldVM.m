//
//  JWDramaChirldVM.m
//  BagNews
//
//  Created by 微凉 on 16/5/2.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWDramaChirldVM.h"
#import "JWNetTool.h"
#import "JWDramaChirldModel.h"
@implementation JWDramaChirldVM
+ (void)getVideoInfo:(NSString *)url CallBack:(void (^)(NSArray *))callBack
{
    __block NSMutableArray *dataArr = [NSMutableArray array];
    [JWNetTool getWithURL:url Parameter:nil Progress:nil Success:^(id result) {
        NSArray *list = [result objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            [dataArr addObject:[JWDramaChirldModel objectWithDict:dic]];
        }
        callBack(dataArr);
    } Failure:^(id result) {
        
        NSArray *list = [result objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            [dataArr addObject:[JWDramaChirldModel objectWithDict:dic]];
        }
        callBack(dataArr);
    } HttpHeader:nil ResponseType:ResponseTypeJSON];

}
@end
