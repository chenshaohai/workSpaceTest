//
//  IWMeCollectModel.h
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWMeCollectModel : NSObject
// 图片
@property (nonatomic,copy)NSString *collectId;
// 名字
@property (nonatomic,copy)NSString *productId;
// 图片
@property (nonatomic,copy)NSString *img;
// 名字
@property (nonatomic,copy)NSString *name;
/* {
 collectId = 2;
 integral = 0;
 productId = 2;
 productName = "Apple iPhone 5s  \U79fb\U52a8\U8054\U901a4G\U624b\U673a\U56fd\U884c\U7cbe\U54c1";
 salePrice = 55;
 smarketPrice = 99;
 thumbImg = "6fe1a863-571f-41d6-9d59-869bf26842dc";
 }
 */
// 价格
@property (nonatomic,copy)NSString *price;
// 市场价
@property (nonatomic,copy)NSString *allPrice;
// 库存
@property (nonatomic,copy)NSString *stock;

- (id)initWithDic:(NSDictionary *)dic;
@end
