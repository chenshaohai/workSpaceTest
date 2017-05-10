//
//  IWDetailSkuModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDetailSkuModel : NSObject
// 规格ID
@property (nonatomic,copy)NSString *attributeId;
// 规格名字
@property (nonatomic,copy)NSString *attributeName;
// 具体规格值
@property (nonatomic,strong)NSArray *skuInfos;

@property (nonatomic,strong)NSMutableArray *skuInfosModelArr;

// Frame
@property (nonatomic,assign,readonly)CGRect nameF;
@property (nonatomic,strong)NSMutableArray *btnFArr;
// cellH
@property (nonatomic,assign)CGFloat cellH;

- (id)initWithDic:(NSDictionary *)dic;
@end
