//
//  JWNetTool.h
//  BagNews
//
//  Created by 微凉 on 16/4/13.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void(^ProgressBlock)(NSProgress *progress);
typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(id result);

typedef NS_ENUM(NSUInteger, ResponseType) {
    ResponseTypeDATA,
    ResponseTypeJSON,
    ResponseTypeXML,
};
@interface JWNetTool : NSObject
+ (void)getWithURL:(NSString *)url
         Parameter:(NSDictionary *)parameter
          Progress:(ProgressBlock)progress
           Success:(SuccessBlock)success
           Failure:(FailureBlock)failure
        HttpHeader:(NSDictionary<NSString*, NSString *> *)header
      ResponseType:(ResponseType)responseType;
@end
