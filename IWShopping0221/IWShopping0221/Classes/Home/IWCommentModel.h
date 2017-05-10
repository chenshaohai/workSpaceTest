//
//  IWCommentModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWCommentModel : NSObject
// 时间
@property (nonatomic,copy)NSString *createdTime;
// 评论
@property (nonatomic,copy)NSString *evaluateDesc;
// score
@property (nonatomic,copy)NSString *score;
// userId
@property (nonatomic,copy)NSString *userId;
// userImg
@property (nonatomic,copy)NSString *userImg;
// userName
@property (nonatomic,copy)NSString *userName;


// frame
@property (nonatomic,readonly,assign) CGRect createdTimeF;
@property (nonatomic,readonly,assign) CGRect userImgF;
@property (nonatomic,readonly,assign) CGRect userNameF;
@property (nonatomic,readonly,assign) CGRect evaluateDescF;
// cellH
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
