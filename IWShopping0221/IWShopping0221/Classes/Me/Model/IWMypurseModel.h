//
//  IWMypurseModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/3.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWMypurseModel : NSObject
// 图片
@property (nonatomic,copy)NSString *topImg;
// 名字
@property (nonatomic,copy)NSString *name;
// content
@property (nonatomic,copy)NSString *content;
// 右箭头图标
@property (nonatomic,copy)NSString *rightImg;

// frame
@property (readonly,assign,nonatomic)CGRect topImgF;
@property (readonly,assign,nonatomic)CGRect nameF;
@property (readonly,assign,nonatomic)CGRect contentF;
@property (readonly,assign,nonatomic)CGRect rightImgF;

- (id)initWithDic:(NSDictionary *)dic;
@end
