//
//  IWGategoryTwoModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/2.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWGategoryTwoModel : NSObject
// 图片
@property (nonatomic,copy)NSString *cateIconImg;
// id
@property (nonatomic,copy)NSString *cateId;
// 名字
@property (nonatomic,copy)NSString *cateName;
// 子类
@property (nonatomic,strong)NSArray *children;

- (id)initWithDic:(NSDictionary *)dic;
@end
