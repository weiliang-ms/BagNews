//
//  NSObject+JSONExtension.h
//  RuntimeDemo
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONExtension)
+ (instancetype)objectWithDict:(NSDictionary *)dict;
- (NSString *)arrayObjectClass;
// 归档反归档
- (NSArray *)ignoredNames;
- (void)xzx_encode:(NSCoder *)aCoder;
- (void)xzx_decode:(NSCoder *)aDecoder;

@end
