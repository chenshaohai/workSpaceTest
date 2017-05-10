//
//  IWDetailsModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/25.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDetailsModel : NSObject
// 每包多少千克
@property (nonatomic,strong)NSArray *standardArr;
// 购买须知
@property (nonatomic,copy)NSString *knowStr;
// 税率
@property (nonatomic,copy)NSString *taxRate;
// 网址
@property (nonatomic,copy)NSString *imgUrl;

// Frame
// 规格背景
@property (nonatomic,readonly,assign) CGRect standardViewF;
// 规格label
@property (nonatomic,readonly,assign) CGRect standardLabelF;
// 按钮Frame集合
@property (nonatomic,strong) NSMutableArray *btnFArr;
// cell1高度
@property (nonatomic,assign) CGFloat cellOneH;
// 购买数量
@property (nonatomic,assign) CGFloat shoopNumW;
// 购买须知(运费,税费)
@property (nonatomic,readonly,assign)CGRect freightF;
// 税率
@property (nonatomic,readonly,assign)CGRect taxRateF;
// cell2高度
@property (nonatomic,assign) CGFloat cellTwoH;
// 图片尺寸
@property (nonatomic,assign) CGSize imgSize;
// cell3高度
@property (nonatomic,assign) CGFloat cellThreeH;

- (id)initWithDic:(NSDictionary *)dic;
@end
