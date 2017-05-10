//
//  IWCommentModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWCommentModel.h"

@implementation IWCommentModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _createdTime = [NSDate dateToyyyyMMddStringWithInteger:[dic[@"createdTime"]?dic[@"createdTime"]:@"" doubleValue]];
        _evaluateDesc = dic[@"evaluateDesc"]?dic[@"evaluateDesc"]:@"";
        _score = dic[@"score"]?dic[@"score"]:@"";
        _userId = dic[@"userId"]?dic[@"userId"]:@"";
        _userImg = dic[@"userImg"]?dic[@"userImg"]:@"";
        _userName = dic[@"userName"]?dic[@"userName"]:@"";
        
        [self frame];
    }
    return self;
}

- (void)frame{
    // 头像
    _userImgF = CGRectMake(kFRate(10), kFRate(15), kFRate(30), kFRate(30));
    
    // 时间
    CGSize timeSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kFont24px text:_createdTime];
    _createdTimeF = CGRectMake(kViewWidth/2 ,kFRate(15) + (kFRate(30) - timeSize.height) / 2, kViewWidth/2 - kFRate(10), timeSize.height);
    
    // 内容
    CGSize evaluateDescSize = [self initWithWidth:kViewWidth - kFRate(20) height:MAXFLOAT font:kFont28px text:_evaluateDesc];
    _evaluateDescF = CGRectMake(kFRate(10), CGRectGetMaxY(_userImgF) + kFRate(10), kViewWidth - kFRate(20), evaluateDescSize.height);
    
    // 名字
    CGSize nameSize = [self initWithWidth:kViewWidth/2 - CGRectGetMaxX(_userImgF) - kFRate(10) height:MAXFLOAT font:kFont24px text:_userName];
    _userNameF = CGRectMake(CGRectGetMaxX(_userImgF) + kFRate(10), _createdTimeF.origin.y, kViewWidth/2 - CGRectGetMaxX(_userImgF) - kFRate(10), nameSize.height);
    
    _cellH = CGRectGetMaxY(_evaluateDescF) + kFRate(15);
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}
@end
