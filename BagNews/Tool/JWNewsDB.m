//
//  JWNewsDB.m
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWNewsDB.h"
#import "FMDBTool.h"

static FMDatabase *db;
@implementation JWNewsDB
+ (instancetype)share
{
    static JWNewsDB *news = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!news) {
            news = [[JWNewsDB alloc] init];
            NSArray *defaultArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DefaultURLS" ofType:@"plist"]];
            NSArray *otherArr = [ NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"OtherURLS" ofType:@"plist"]];
            FMDBTool *tool =  [FMDBTool tool];
            
            db = [tool getDBWithDBName:NEWSDBNAME];
            NSArray *array = [news selectKeyTypes:@{
                                                    @"title":@"text",
                                                    @"url":@"text"
                                                    
                                                    } fromTable:NEWSDEFAULTT];
            if (!array.count) {
                [tool DataBase:db createTable:NEWSDEFAULTT keyTypes:@{
                                                                      @"title":@"text",
                                                                      @"url":@"text"
                                                                      
                                                                      }];
                [tool DataBase:db createTable:NEWSOTHERT keyTypes:@{
                                                                    @"title":@"text",
                                                                    @"url":@"text"
                                                                    }];
                for (NSDictionary *temp in defaultArr) {
                    [tool DataBase:db insertKeyValues:temp intoTable:NEWSDEFAULTT];
                }
                for (NSDictionary *temp in otherArr) {
                    [tool DataBase:db insertKeyValues:temp intoTable:NEWSOTHERT];
                }

            }
        }
           });
    
    return news;
}
- (void)insertKeyValues:(NSDictionary *)keyValues TableName:(NSString *)tableName
{
    FMDBTool *tool = [FMDBTool tool];
    if ([tool isOpenDatabese:db]) {
        
        NSArray *keys = [keyValues allKeys];
        
        NSArray *values = [keyValues allValues];
        
        NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@ (", tableName]];
        
        NSInteger count = 0;
        
        for (NSString *key in keys) {
            
            
            
            [sql appendString:key];
            
            count ++;
            
            if (count < [keys count]) {
                
                
                
                [sql appendString:@", "];
                
            }
            
        }
        
        
        
        [sql appendString:@") VALUES ("];
        
        
        
        
        
        for (int i = 0; i < [values count]; i++) {
            
            
            
            [sql appendString:@"?"];
            
            
            
            if (i < [values count] - 1) {
                
                
                
                [sql appendString:@","];
                
            }
            
            
            
        }
        
        
        
        [sql appendString:@")"];
        
        
        
        NSLog(@"%@", sql);
        
        
        
        [db executeUpdate:sql withArgumentsInArray:values];
        
    }
    
    

}

- (NSArray *)selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName
{
    FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ LIMIT 100",tableName]];
    
    return [self getArrWithFMResultSet:result keyTypes:keyTypes];
}

-(NSArray *)getArrWithFMResultSet:(FMResultSet *)result keyTypes:(NSDictionary *)keyTypes
{
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    while ([result next]) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < keyTypes.count; i++) {
            
            NSString *key = [keyTypes allKeys][i];
            
            NSString *value = [keyTypes valueForKey:key];
            
            if ([value isEqualToString:@"text"]) {
                
                //                字符串
                
                [tempDic setValue:[result stringForColumn:key] forKey:key];
                
            }else if([value isEqualToString:@"blob"])
                
            {
                
                //                二进制对象
                
                [tempDic setValue:[result dataForColumn:key] forKey:key];
                
            }else if ([value isEqualToString:@"integer"])
                
            {
                
                //                带符号整数类型
                
                [tempDic setValue:[NSNumber numberWithInt:[result intForColumn:key]]forKey:key];
                
            }else if ([value isEqualToString:@"boolean"])
                
            {
                
                //                BOOL型
                
                [tempDic setValue:[NSNumber numberWithBool:[result boolForColumn:key]] forKey:key];
                
                
                
            }else if ([value isEqualToString:@"date"])
                
            {
                
                //                date
                
                [tempDic setValue:[result dateForColumn:key] forKey:key];
                
            }
            
            
            
        }
        
        [tempArr addObject:tempDic];
        
    }
    
    return tempArr;
    
    
    
}
#pragma mark --清理指定数据库中的数据


-(void)clearDatabaseFrom:(NSString *)tableName
{
    if ([[FMDBTool tool] isOpenDatabese:db]) {
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
        
    }

}

- (void)deleteDataFrom:(NSString *)tableName Dic:(NSDictionary *)dic
{
    if ([[FMDBTool tool] isOpenDatabese:db]) {
        
        NSString *str = [dic objectForKey:@"title"];
      BOOL res =  [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ where title = '%@'",tableName,str]];
        if (!res) {
            NSLog(@"失败");
        }
        else{
            NSLog(@"成功");
        }
        
    }
}

- (void)creatTable:(NSString *)tableName Arr:(NSArray *)array
{
    [[FMDBTool tool] DataBase:db createTable:tableName keyTypes:@{
                                                          @"title":@"text",
                                                          @"url":@"text"
                                                          
                                                          }];
    for (NSDictionary *temp in array) {
        [[FMDBTool tool] DataBase:db insertKeyValues:temp intoTable:tableName];
    }

}
@end
