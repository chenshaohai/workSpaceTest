//
//  IWHomeCellModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/23.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWHomeCellModel : NSObject
// 图片集合
@property (nonatomic,strong)NSArray *imgs;
// 文字集合
@property (nonatomic,strong)NSArray *titles;

- (id)initWithDic:(NSDictionary *)dic;
@end
