//
//  IWHomeMoreModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWHomeMoreModel : NSObject
// 图片
@property (nonatomic,copy)NSString *img;
// 名字
@property (nonatomic,copy)NSString *name;
// 价格
@property (nonatomic,copy)NSString *price;
// 市场价
@property (nonatomic,copy)NSString *allPrice;
// 库存
@property (nonatomic,copy)NSString *stock;
// id
@property (nonatomic,copy)NSString *productId;

- (id)initWithDic:(NSDictionary *)dic;
@end
