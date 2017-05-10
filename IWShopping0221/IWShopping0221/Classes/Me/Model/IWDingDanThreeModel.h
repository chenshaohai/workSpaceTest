//
//  IWDingDanThreeModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDingDanThreeModel : NSObject
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
// 配送方式
@property (nonatomic,copy)NSString *peiSong;
@property (nonatomic,copy)NSString *distribution;
// 支付方式
@property (nonatomic,copy)NSString *way;
@property (nonatomic,copy)NSString *payWay;
// 购买数量
@property (nonatomic,copy)NSString *shopNum;


@property (nonatomic,assign,readonly)CGRect shopNameF;
// 图片
@property (nonatomic,assign,readonly)CGRect goodsImgF;
// 名字
@property (nonatomic,assign,readonly)CGRect goodsNameF;
// 规格
@property (nonatomic,assign,readonly)CGRect goodsSkuF;
// 价格
@property (nonatomic,assign,readonly)CGRect goodsPriceF;
// 配送方式
@property (nonatomic,assign,readonly)CGRect peiSongF;
@property (nonatomic,assign,readonly)CGRect distributionF;
// 支付方式
@property (nonatomic,assign,readonly)CGRect wayF;
@property (nonatomic,assign,readonly)CGRect payWayF;
// 购买数量
@property (nonatomic,assign,readonly)CGRect shopNumF;

@property (nonatomic,assign,readonly)CGRect tableThreeF;
@property (nonatomic,assign,readonly)CGRect linThreeF;
@property (nonatomic,assign,readonly)CGRect linFiveF;
@property (nonatomic,assign,readonly)CGRect linSixF;
// cellH
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
