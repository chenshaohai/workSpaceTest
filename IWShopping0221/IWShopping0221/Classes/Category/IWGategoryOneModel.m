//
//  IWGategoryOneModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/2.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGategoryOneModel.h"
#import "IWGategoryTwoModel.h"

@implementation IWGategoryOneModel
- (id)initWithDic:(NSDictionary *)dic
{
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
        
        CGSize maximumLabelSize = CGSizeMake(MAXFLOAT, kRate(30));//labelsize的最大值
        NSDictionary *attribute = @{NSFontAttributeName: kFont24px};
        CGSize expectSize = [self.cateName boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        _btnW = expectSize.width;
    }
    return self;
}
@end
