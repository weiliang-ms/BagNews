//
//  NSDictionary+Tools.h
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Tools)
/*
 *未排序的参数
 */
- (NSString*)appendGetParameterWithBasePath:(NSString*)path;
/*
 *已经排序的参数
 */
- (NSString*)appendGetSortParameterWithBasePath:(NSString*)path;
/*
 *已经排序的参数自动加上sign
 */
- (NSString*)appendGetSortParameterWithSignWithBasePath:(NSString*)path;

@end
