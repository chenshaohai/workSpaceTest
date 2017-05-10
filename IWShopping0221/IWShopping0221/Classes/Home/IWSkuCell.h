//
//  IWSkuCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWDetailSkuModel.h"
#import "IWDetailSkuInfosModel.h"

@interface IWSkuCell : UITableViewCell
// 模型
@property (nonatomic,strong)IWDetailSkuModel *skuModel;
// 回调选择规格
@property (nonatomic,copy) void (^IWChooseSku)(NSInteger tag);
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
