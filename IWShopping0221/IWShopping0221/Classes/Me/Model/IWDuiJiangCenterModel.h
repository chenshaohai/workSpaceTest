//
//  IWDuiJiangCenterModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/9.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWDuiJiangCenterModel : NSObject
// 图片
@property (nonatomic,copy)NSString *topImg;
// name
@property (nonatomic,copy)NSString *name;
// 抽奖日期
@property (nonatomic,copy)NSString *chouJiangDate;
// 兑奖日期
@property (nonatomic,copy)NSString *duiJiangDate;

// frame
@property (nonatomic,assign,readonly)CGRect topImgF;
@property (nonatomic,assign,readonly)CGRect nameF;
@property (nonatomic,assign,readonly)CGRect chouJiangF;
@property (nonatomic,assign,readonly)CGRect duiJiangF;
@property (nonatomic,assign,readonly)CGRect btnF;
@property (nonatomic,assign)CGFloat cellH;
@property (nonatomic,assign,readonly)CGRect linF;
- (id)initWithDic:(NSDictionary *)dic;
@end
