//
//  NSDictionary+Tools.m
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "NSDictionary+Tools.h"

#import "NSString+Tools.h"
@implementation NSDictionary (Tools)
- (NSString*)appendGetParameterWithBasePath:(NSString*)path{
    NSMutableString* basePath = [[NSMutableString alloc] initWithString:path];
    [self enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
        [basePath appendFormat:@"%@=%@&",key,obj];
    }];
    return [[basePath substringWithRange: NSMakeRange(0, basePath.length - 1)] copy];
}

- (NSString*)appendGetSortParameterWithBasePath:(NSString*)path{
    NSMutableString* basePath = [[NSMutableString alloc] initWithString:path];
    //排序后的keys
    NSArray* keysArr = [self allKeys];
    keysArr = [keysArr sortedArrayUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString*  _Nonnull obj2) {
        NSComparisonResult re = [obj1 compare: obj2];
        return re == NSOrderedDescending;
    }];
    
    [keysArr enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [basePath appendFormat:@"%@=%@&",obj,self[obj]];
    }];
    //去掉最后一个多余的&
    return [[basePath substringWithRange: NSMakeRange(0, basePath.length - 1)] copy];
}

- (NSString*)appendGetSortParameterWithSignWithBasePath:(NSString*)path{
    NSString* sortParamer = [self appendGetSortParameterWithBasePath: @""];
    //拼上sign
    sortParamer = [NSString stringWithFormat:@"%@%@&sign=%@",path,sortParamer,[NSString signStringWithString: sortParamer]];
    return sortParamer;
}

@end
