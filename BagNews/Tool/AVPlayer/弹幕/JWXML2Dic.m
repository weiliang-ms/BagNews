//
//  JWXML2Dic.m
//  BagNews
//
//  Created by 微凉 on 16/5/4.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWXML2Dic.h"
#import "JWDanmuModel.h"
@interface JWXML2Dic ()
@property (nonatomic, strong) NSString* currentAttribute;
@property (nonatomic, strong) NSMutableDictionary<NSNumber*,NSMutableArray<JWDanmuModel*>*>* dic;
@end
@implementation JWXML2Dic
+ (NSDictionary*)dicWithData:(NSString*)data{
    JWXML2Dic* sd = [[JWXML2Dic alloc] init];
    [sd parseWithData:data];
    return sd.dic;
}

- (void)parseWithData:(NSString*)str{

    NSRegularExpression* regu = [[NSRegularExpression alloc] initWithPattern:@"<d.*>" options:NSRegularExpressionCaseInsensitive error:nil];
    //正则表达式匹配的范围
    NSArray<NSTextCheckingResult*>* resultArr = [regu matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    //所有弹幕标签
    for (NSTextCheckingResult* re in resultArr) {
        NSString* subStr = [str substringWithRange:re.range];
        JWDanmuModel* model = [JWDanmuModel modelWithParameter:[self getParameterWithString:subStr] text:[self getTextWithString:subStr]];
        if (self.dic[model.sendTime] == nil) {
            self.dic[model.sendTime] = [NSMutableArray array];
        }
        [self.dic[model.sendTime] addObject: model];
    }
}

//获取参数
- (NSString*)getParameterWithString:(NSString*)str{
    NSRegularExpression* regu = [[NSRegularExpression alloc] initWithPattern:@"\".*\"" options:NSRegularExpressionCaseInsensitive error:nil];
    //正则表达式匹配的范围
    NSArray<NSTextCheckingResult*>* resultArr = [regu matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    if (resultArr.count > 0) {
        return [str substringWithRange:NSMakeRange(resultArr.firstObject.range.location + 1, resultArr.firstObject.range.length - 2)];
    }
    return nil;
}

// 获取内容
- (NSString*)getTextWithString:(NSString*)str{
    NSRegularExpression* regu = [[NSRegularExpression alloc] initWithPattern:@">.*<" options:NSRegularExpressionCaseInsensitive error:nil];
    //正则表达式匹配的范围
    NSArray<NSTextCheckingResult*>* resultArr = [regu matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    if (resultArr.count > 0) {
        return [str substringWithRange:NSMakeRange(resultArr.firstObject.range.location + 1, resultArr.firstObject.range.length - 2)];
    }
    return nil;
}


- (NSMutableDictionary<NSNumber *,NSMutableArray<JWDanmuModel*> *> *)dic{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

@end
