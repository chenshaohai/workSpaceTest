//
//  IWNearShoppingDetailDiscussModel.m
//  IWShopping0221
//
//  Created by FRadmin on 17/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearShoppingDetailDiscussModel.h"

@implementation IWNearShoppingDetailDiscussModel

#define  firstX  16
#define  firstY  16

+(id)modelWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self)
    {
        _modelId = dic[@"evaluateId"]?dic[@"evaluateId"]:@"";
        _name = dic[@"userName"]?dic[@"userName"]:@"";
        _content = dic[@"evaluateDesc"]?dic[@"evaluateDesc"]:@"";
        _time = [NSDate dateToyyyyMMddHHmmssStringWithInteger:[dic[@"createdTime"]?dic[@"createdTime"]:@"" doubleValue]];
        _logo = dic[@"userImg"]?dic[@"userImg"]:@"";
        
        _score = dic[@"score"]?dic[@"score"]:@"0";
        // 头像
        _logoFrame = CGRectMake(kFRate(10), kFRate(15), kFRate(30), kFRate(30));
        // 名字
        CGSize nameSize = [self initWithWidth:kViewWidth/2 - CGRectGetMaxX(_logoFrame) - kFRate(10) height:MAXFLOAT font:kFont24px text:_name];
        _nameFrame = CGRectMake(CGRectGetMaxX(_logoFrame) + kFRate(10), kFRate(15), kViewWidth/2 - CGRectGetMaxX(_logoFrame) - kFRate(10), nameSize.height);
        
        // 时间
        CGSize timeSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kFont24px text:_time];
        _timeFrame = CGRectMake(CGRectGetMinX(_nameFrame) ,CGRectGetMaxY(_nameFrame) + kFRate(10), kViewWidth/2 - kFRate(10), timeSize.height);
        
        // 内容
        CGSize evaluateDescSize = [self initWithWidth:kViewWidth - kFRate(20) height:MAXFLOAT font:kFont28px text:_content];
        _contentFrame = CGRectMake(kFRate(10), CGRectGetMaxY(_timeFrame) + kFRate(10), kViewWidth - kFRate(20), evaluateDescSize.height);
        
        
        _starFrame = CGRectMake(kViewWidth - kFRate(75) - kFRate(10), CGRectGetMinY(_nameFrame), kFRate(75),  kFRate(13));
        
        
        _cellH = CGRectGetMaxY(_contentFrame) + kFRate(15);
       
        _lineFrame = CGRectMake(kFRate(10), _cellH - kFRate(0.5), kViewWidth - kFRate(20), kFRate(0.5));
    }
    return self;
}
- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}
@end
