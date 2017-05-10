//
//  IWDetailImagesModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailImagesModel.h"

@implementation IWDetailImagesModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _thumbImg = [NSString stringWithFormat:@"%@%@",kImageUrl,dic[@"thumbImg"]?dic[@"thumbImg"]:@""];
    }
    return self;
}
@end
