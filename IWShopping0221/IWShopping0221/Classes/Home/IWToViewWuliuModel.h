//
//  IWToViewWuliuModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWToViewWuliuModel : NSObject
// EBusinessID
@property (nonatomic,copy)NSString *EBusinessID;
// 单号
@property (nonatomic,copy)NSString *LogisticCode;
// 物流
@property (nonatomic,copy)NSString *ShipperCode;
// State
@property (nonatomic,copy)NSString *State;
// Traces
@property (nonatomic,strong)NSArray *Traces;

// model集合
@property (nonatomic,strong)NSMutableArray *tracesModelArr;

- (id)initWithDic:(NSDictionary *)dic;

@end
