//
//  JWNewsDB.h
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWNewsDB : NSObject
+ (instancetype)share;
- (void)insertKeyValues:(NSDictionary *)keyValues TableName:(NSString *)tableName;
-(NSArray *)selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName;
// 删表
-(void)clearDatabaseFrom:(NSString *)tableName;
// 建表并赋值
- (void)creatTable:(NSString *)tableName Arr:(NSArray *)array;
- (void)deleteDataFrom:(NSString *)tableName Dic:(NSDictionary *)dic;
@end
