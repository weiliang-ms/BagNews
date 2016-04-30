//
//  NSObject+JSONExtension.m
//  RuntimeDemo
//
//  Created by 微凉 on 16/4/28.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "NSObject+JSONExtension.h"
#import <objc/runtime.h>  // 运行时框架
@implementation NSObject (JSONExtension)
// 外界模型赋值接口 通过该接口可以实现给模型里的属性赋值
+ (instancetype)objectWithDict:(NSDictionary *)dict
{
    // 封装初始化
    NSObject *object = [[self alloc] init];
    [object setValueWithDict:dict];
    return object;
}

- (void)setValueWithDict:(NSDictionary *)dict
{
    Class class = self.class;
    while (class && class != [NSObject class]) {
        // 初始化成员变量个数
        unsigned int count = 0;
        // 获取成员变量数组
        Ivar *ivars = class_copyIvarList(class, &count);
        // 遍历数组里面的成员变量
        for (int i = 0; i < count; i++) {
            // 获取成员变量
            Ivar ivar = ivars[i];
            // 获取成员变量名字
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 成员变量名转为属性名（去掉下划线_）
            key = [key substringFromIndex:1];
            // 取出字典中key对应的value
            id value = dict[key];
            // 如果模型属性数量大于字典键值对数量，模型属性会被赋值为nil而报错
            if(value == nil)continue;
            
            // 获得成员变量类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            // 如果属性是对象类型
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
            // 那么截取对象的名字（比如@"Dog"，截取为Dog）
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                // 排除系统对象类型
                if (![type hasPrefix:@"NS"]) {
                // 将对象名转换为对象的类型，将新的对象字典转模型（递归）
                    Class newClass = NSClassFromString(type);
                    value = [newClass objectWithDict:value];
                }else if([type isEqualToString:@"NSArray"])
                {
                    // 如果是数组类型，将数组中的每个模型进行字典转模型，先创建一个临时数组存放模型
                    NSArray *array = (NSArray *)value;
                    NSMutableArray *mArray = [NSMutableArray array];
                    
                    // 获取到每个模型的类型
                    id newClass ;
                    if ([self respondsToSelector:@selector(arrayObjectClass)]) {
                        
                        NSString *classStr = [self arrayObjectClass];
                        newClass = NSClassFromString(classStr);

                    }
                    // 将数组中的所有模型进行字典转模型
                    for (int i = 0; i < array.count; i++) {
                        [mArray addObject:[newClass objectWithDict:value[i]]];
                    }
                    
                    value = mArray;
            }
            
        }
            // 将字典中的值设置到模型上
            [self setValue:value forKeyPath:key];
        }
        free(ivars);
        class = [class superclass];
        
    }
}
- (NSString *)arrayObjectClass{return nil;}
@end
