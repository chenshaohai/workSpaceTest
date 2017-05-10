//
//  EPObPartProjectViewModel.m
//  E-Platform
//
//  Created by 陈敬 on 2017/3/21.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "EPObPartProjectViewModel.h"

@implementation EPObPartProjectViewModel
+(id)modelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _headImageName = dic[@"headImageName"]?dic[@"headImageName"]:@"";
        _topLabelText = dic[@"topLabelText"]?dic[@"topLabelText"]:@"";
        _numberText = dic[@"numberText"]?dic[@"numberText"]:@"";
        _adminText = dic[@"adminText"]?dic[@"adminText"]:@"";
        _scheduleText = dic[@"scheduleText"]?dic[@"scheduleText"]:@"";
        
        _isShowWaring = NO;
    }
    return self;
}

@end
