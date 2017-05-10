//
//  IWHomeBanderModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/1.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeBanderModel.h"

@implementation IWHomeBanderModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.bannerId = dic[@"bannerId"]?dic[@"bannerId"]:@"";
        // [NSString stringWithFormat:@"http://weiyun-10047376.image.myqcloud.com/%@",dic[@"bannerImg"]?dic[@"bannerImg"]:@""]
        self.bannerImg = [NSString stringWithFormat:@"%@%@",kImageUrl,dic[@"bannerImg"]?dic[@"bannerImg"]:@""];
        self.bannerName = dic[@"bannerName"]?dic[@"bannerName"]:@"";
        self.targetUrl = dic[@"targetUrl"]?dic[@"targetUrl"]:@"";
    }
    return self;
}
@end
