//
//  IWToViewWuliuModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWToViewWuliuModel.h"
#import "IWToViewModel.h"

@implementation IWToViewWuliuModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _tracesModelArr = [[NSMutableArray alloc] init];
        _EBusinessID = dic[@"EBusinessID"]?dic[@"EBusinessID"]:@"";
        _LogisticCode = dic[@"LogisticCode"]?dic[@"LogisticCode"]:@"";
        _ShipperCode = dic[@"ShipperCode"]?dic[@"ShipperCode"]:@"";
        _State = dic[@"State"]?dic[@"State"]:@"";
        _Traces = dic[@"Traces"]?dic[@"Traces"]:nil;
        
        if (_Traces && _Traces.count > 0) {
            for (NSDictionary *dic in _Traces) {
                IWToViewModel *model = [[IWToViewModel alloc] initWithDic:dic];
                [_tracesModelArr addObject:model];
            }
        }
    }
    return self;
}
@end
