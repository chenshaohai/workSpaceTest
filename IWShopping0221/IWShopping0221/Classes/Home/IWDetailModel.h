//
//  IWDetailModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDetailModel : NSObject
//
@property (nonatomic,copy)NSString *expressConfig;
//邮费("0"表示免邮费)
@property (nonatomic,copy)NSString *expressMoney;
//images 顶部图片
@property (nonatomic,strong)NSArray *images;
//会币(null)
@property (nonatomic,copy)NSString *integral;
//productDescUrl 展示详情图片链接
@property (nonatomic,copy)NSString *productDescUrl;
//商品ID
@property (nonatomic,copy)NSString *productId;
//商品名字
@property (nonatomic,copy)NSString *productName;
//订单编号
@property (nonatomic,copy)NSString *productNum;
//
@property (nonatomic,copy)NSString *purchase;
//销量
@property (nonatomic,copy)NSString *saleCount;
//销售价
@property (nonatomic,copy)NSString *salePrice;
//店铺ID
@property (nonatomic,copy)NSString *shopId;
//规格数组
@property (nonatomic,strong)NSArray *sku;
//
@property (nonatomic,copy)NSString *skuCustom;
//市场价
@property (nonatomic,copy)NSString *smarketPrice;
//
@property (nonatomic,copy)NSString *specAttributeIds;
//是否有规格参数("1"表示有)
@property (nonatomic,copy)NSString *specConfig;
//库存
@property (nonatomic,copy)NSString *stock;
//
@property (nonatomic,copy)NSString *thumbImg;
// 配对items
@property (nonatomic,strong)NSArray *items;

// 图片模型集合
@property (nonatomic,strong)NSMutableArray *imgModelArr;
// 规格模型集合
@property (nonatomic,strong)NSMutableArray *skuModelArr;
// items模型集合
@property (nonatomic,strong)NSMutableArray *itemsModelArr;

// Frame
@property (nonatomic,assign)CGFloat nameH;
@property (nonatomic,assign)CGFloat headerH;
@property (nonatomic,assign)CGFloat webViewH;

- (id)initWithDic:(NSDictionary *)dic;
@end
