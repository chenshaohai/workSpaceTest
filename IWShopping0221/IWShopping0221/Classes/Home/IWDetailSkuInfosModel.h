//
//  IWDetailSkuInfosModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDetailSkuInfosModel : NSObject
//
@property (nonatomic,copy)NSString *attValArr;
//
@property (nonatomic,copy)NSString *attributeValueId;
// 名字(按钮展示)
@property (nonatomic,copy)NSString *attributeValueName;
// itemId
@property (nonatomic,copy)NSString *itemId;
// 价格
@property (nonatomic,copy)NSString *salePrice;
// 库存
@property (nonatomic,copy)NSString *stock;

- (id)initWithDic:(NSDictionary *)dic;
@end
