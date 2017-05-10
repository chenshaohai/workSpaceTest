//
//  IWHomeRegionModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/1.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeRegionModel.h"

@implementation IWHomeRegionModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.productArr = [[NSMutableArray alloc] init];
        self.regionId = dic[@"regionId"]?dic[@"regionId"]:@"";
        self.regionName = dic[@"regionName"]?dic[@"regionName"]:@"";
        self.regionProduct = dic[@"regionProduct"]?dic[@"regionProduct"]:@[];
        if ([self.regionProduct isKindOfClass:[NSArray class]] && self.regionProduct.count > 0) {
            NSInteger indexNum = 0;
            if (self.regionProduct.count > 3) {
                indexNum = 3;
            }else{
                indexNum = self.regionProduct.count;
            }
            for (NSInteger i = 0; i < indexNum ;i ++) {
                NSDictionary *dic = self.regionProduct[i];
                IWHomeRegionProductModel *model = [[IWHomeRegionProductModel alloc] initWithDic:dic];
                [self.productArr addObject:model];
            }
        }
    }
    return self;
}
@end
