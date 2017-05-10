//
//  IWDuiJiangCenterModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/9.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDuiJiangCenterModel.h"

@implementation IWDuiJiangCenterModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
//        self.topImg = @"";
        self.name = [NSString stringWithFormat:@"奖品名称：%@",dic[@"gift"]?:@""];
        self.chouJiangDate = [NSString stringWithFormat:@"中奖时间：%@",[NSDate dateToyyyyMMddHHmmssStringWithInteger:[dic[@"createdTime"]?dic[@"createdTime"]:@"" doubleValue]]];
//        self.duiJiangDate = [NSString stringWithFormat:@"兑奖日期：%@",@"2017-02-02 23:33:33"];
        
        [self frame];
    }
    return self;
}

- (void)frame{
    // 左边距离
//    CGFloat leftX = kFRate(10);
    // label宽
    CGFloat labelW = kViewWidth - kFRate(10);
    // label高
    CGFloat labelH = kFRate(18);
    
    // 图片
//    _topImgF = CGRectMake(leftX, leftX, kFRate(75), kFRate(75));
    
    // name
    CGFloat nameX = kFRate(10);
    _nameF = CGRectMake(nameX, kFRate(15), labelW, labelH);
    
    // 抽奖日期
    _chouJiangF = CGRectMake(nameX, CGRectGetMaxY(_nameF) + kFRate(5), labelW, labelH);
    
    // 兑奖日期
//    _duiJiangF = CGRectMake(nameX, CGRectGetMaxY(_chouJiangF), labelW, labelH);
    
    // 兑奖按钮
//    _btnF = CGRectMake(nameX, CGRectGetMaxY(_duiJiangF) + kFRate(5) , kFRate(50), kFRate(15));
    
    _cellH = CGRectGetMaxY(_chouJiangF) + kFRate(15);
    
    _linF = CGRectMake(0, _cellH - kFRate(0.5), kViewWidth, kFRate(0.5));
}

@end
