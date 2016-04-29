//
//  JWNetTool.m
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNetTool.h"

@implementation JWNetTool
+ (void)getWithURL:(NSString *)url
         Parameter:(NSDictionary *)parameter
          Progress:(ProgressBlock)progress
           Success:(SuccessBlock)success
           Failure:(FailureBlock)failure
        HttpHeader:(NSDictionary<NSString*, NSString *> *)header
      ResponseType:(ResponseType)responseType
{
    // 缓存的文件夹
    NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[url hash]];
    NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 反归档
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
    
    // 初始化sessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 处理请求头
    for (NSString *key in header.allKeys) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    
    // 处理返回值类型
    switch (responseType) {
        case ResponseTypeDATA:
        {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        case ResponseTypeJSON:
        {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case ResponseTypeXML:
        {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
    }
    
    // 设置返回值支持的文本类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"text/json", @"text/javascript", @"text/plain",@"application/json", nil]];
    
    // get请求
    [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                
                //  成功之后异步缓存数据
                NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[url hash]];
                // 存储的沙盒路径
                NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                // 归档
                [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
                
                NSLog(@"缓存路径%@",path_doc);
                
                
            });

        }
        
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (result) {
                failure(result);
                NSLog(@"返回解档数据");
            }else
            {
                NSLog(@"%@",error);

            }
            
        }
    }];
}

@end
