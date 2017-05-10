//
//  IWHomeRegionModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/1.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWHomeRegionProductModel.h"


@interface IWHomeRegionModel : NSObject
// id
@property (nonatomic,copy)NSString *regionId;
// 名字
@property (nonatomic,copy)NSString *regionName;
// 推荐商品集合
@property (nonatomic,strong)NSArray *regionProduct;
@property (nonatomic,strong)NSMutableArray *productArr;

- (id)initWithDic:(NSDictionary *)dic;
@end
