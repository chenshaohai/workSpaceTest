//
//  IWMypurseModel.m
//  IWShopping0221
//
//  Created by admin on 2017/3/3.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMypurseModel.h"

@implementation IWMypurseModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.topImg = dic[@"topImg"];
        self.name = dic[@"name"];
        self.content = dic[@"content"];
        self.rightImg = dic[@"rightImg"];
        
        [self frame];
    }
    return self;
}

- (void)frame{
    _topImgF = CGRectMake(0, 0, kFRate(50), kFRate(60));
    
    CGSize maximumLabelSize = CGSizeMake(MAXFLOAT, kFRate(60));//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName: kFont30px};
    CGSize expectSize = [self.name boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    _nameF = CGRectMake(CGRectGetMaxX(_topImgF), 0, expectSize.width, kFRate(60));
    
    _rightImgF = CGRectMake(kViewWidth - kFRate(35), 0, kFRate(35), kFRate(60));
    
    _contentF = CGRectMake(CGRectGetMaxX(_nameF) + kFRate(10), 0, kViewWidth - CGRectGetMaxX(_nameF) - kFRate(10) - kFRate(35), kFRate(60));
}

@end
