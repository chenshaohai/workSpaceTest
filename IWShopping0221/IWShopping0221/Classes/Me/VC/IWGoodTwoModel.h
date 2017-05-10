//
//  IWGoodTwoModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWGoodTwoModel : NSObject
// productID
@property (nonatomic,copy)NSString *productId;
// 店铺名字
@property (nonatomic,copy)NSString *shopName;
// 图片
@property (nonatomic,copy)NSString *goodsImg;
// 名字
@property (nonatomic,copy)NSString *goodsName;
// 规格
@property (nonatomic,copy)NSString *goodsSku;
// 价格
@property (nonatomic,copy)NSString *goodsPrice;
// 购买数量
@property (nonatomic,copy)NSString *shopNum;
// 商品状态
@property (nonatomic,copy)NSString *shopState;


@property (nonatomic,assign,readonly)CGRect shopNameF;
// 图片
@property (nonatomic,assign,readonly)CGRect goodsImgF;
// 名字
@property (nonatomic,assign,readonly)CGRect goodsNameF;
// 规格
@property (nonatomic,assign,readonly)CGRect goodsSkuF;
// 价格
@property (nonatomic,assign,readonly)CGRect goodsPriceF;
// 商品状态
@property (nonatomic,assign,readonly)CGRect shopStateF;

// 购买数量
@property (nonatomic,assign,readonly)CGRect shopNumF;

@property (nonatomic,assign,readonly)CGRect tableThreeF;
@property (nonatomic,assign,readonly)CGRect linThreeF;
// 店铺图标
@property (nonatomic,assign,readonly)CGRect shopImgF;
// cellH
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
