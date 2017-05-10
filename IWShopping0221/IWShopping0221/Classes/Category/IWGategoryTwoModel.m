//
//  IWGategoryTwoModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/2.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGategoryTwoModel.h"
#import "IWGategoryThreeModel.h"

@implementation IWGategoryTwoModel
- (id)initWithDic:(NSDictionary *)dic
{
//    productCateList =         (
//                               {
//                                   cateIconImg = "6245eb70-eea1-43e8-8467-8f788b6763ec";
//                                   cateId = 1;
//                                   cateName = "\U6d41\U884c\U5973\U88c5";
//                                   children =                 (
//                                   );
//                               },
//                               {
//                                   cateIconImg = "6245eb70-eea1-43e8-8467-8f788b6763ec";
//                                   cateId = 5;
//                                   cateName = "\U6d41\U884c\U6570\U7801";
//                                   children =                 (
//                                                               {
//                                                                   cateIconImg = "6245eb70-eea1-43e8-8467-8f788b6763ec";
//                                                                   cateId = 6;
//                                                                   cateName = "\U7535\U8111\U76f8\U5173";
//                                                                   children =                         (
//                                                                                                       {
//                                                                                                           cateIconImg = "6245eb70-eea1-43e8-8467-8f788b6763ec";
//                                                                                                           cateId = 7;
//                                                                                                           cateName = "\U65e0\U7ebf\U9f20\U6807";
//                                                                                                       },
//                                                                                                       {
//                                                                                                           cateIconImg = "6245eb70-eea1-43e8-8467-8f788b6763ec";
//                                                                                                           cateId = 8;
//                                                                                                           cateName = "\U624b\U673a/\U76f8\U673a/MP3";
//                                                                                                       }
//                                                                                                       );
//                                                               }
//                                                               );
//                               }
//                               );

    self = [super init];
    if (self) {
        self.cateIconImg = dic[@"cateIconImg"]?dic[@"cateIconImg"]:@"";
        self.cateId = dic[@"cateId"]?dic[@"cateId"]:@"";
        self.cateName = dic[@"cateName"]?dic[@"cateName"]:@"";
        self.children = dic[@"children"]?dic[@"children"]:@[];
        
        NSMutableArray *modelArray = [NSMutableArray array];
        NSArray *children = dic[@"children"]?dic[@"children"]:nil;
        if (children && [children isKindOfClass:[NSArray class]]) {
            for (NSDictionary *childrenDict in children) {
                IWGategoryTwoModel *model =   [[IWGategoryTwoModel alloc] initWithDic:childrenDict];
                [modelArray addObject:model];
                
            }
        }
        if (modelArray.count > 0) {
            _children = modelArray;
        }else{
            _children = nil;
        }
    }
    return self;
}
@end
