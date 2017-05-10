//
//  IWHomeRegionProductModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/1.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWHomeRegionProductModel : NSObject
// id
@property (nonatomic,copy)NSString *idStr;
// integral
@property (nonatomic,copy)NSString *integral;
// productId
@property (nonatomic,copy)NSString *productId;
// productName
@property (nonatomic,copy)NSString *productName;
// saleCount
@property (nonatomic,copy)NSString *saleCount;
// salePrice
@property (nonatomic,copy)NSString *salePrice;
// smarketPrice
@property (nonatomic,copy)NSString *smarketPrice;
// stock
@property (nonatomic,copy)NSString *stock;
// thumbImg
@property (nonatomic,copy)NSString *thumbImg;
// cellH
@property (nonatomic,assign)CGFloat cellH;
// 价格展示高度
@property (nonatomic,assign)CGFloat textH;

- (id)initWithDic:(NSDictionary *)dic;
@end
