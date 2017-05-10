//
//  IWItemsModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/15.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWItemsModel : NSObject
// 规格匹配段
@property (nonatomic,copy)NSString *attValArr;
// id
@property (nonatomic,copy)NSString *itemId;
// 售价
@property (nonatomic,copy)NSString *salePrice;
// 市场价
@property (nonatomic,copy)NSString *smarketPrice;
// 库存
@property (nonatomic,copy)NSString *stock;

- (id)initWithDic:(NSDictionary *)dic;
@end
