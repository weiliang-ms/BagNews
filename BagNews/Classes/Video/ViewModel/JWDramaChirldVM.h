//
//  JWDramaChirldVM.h
//  BagNews
//
//  Created by 微凉 on 16/5/2.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWViewModel.h"
@interface JWDramaChirldVM : NSObject

+ (void)getVideoInfo:(NSString *)url
            CallBack:(void(^)(NSArray *arr))callBack;
@end
