//
//  JWDramaVM.h
//  BagNews
//
//  Created by 微凉 on 16/4/30.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWViewModel.h"
@class JWVideoViewController;
@interface JWDramaVM : NSObject
+ (void)getNewsWithUrl:(NSString *)url CollectionView:(UICollectionView *)collectionView ViewController:(JWVideoViewController *)viewController;
@end
