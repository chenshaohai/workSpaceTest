//
//  IWDuiJiangCenterCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/9.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWDuiJiangCenterModel.h"

@interface IWDuiJiangCenterCell : UITableViewCell
// 模型
@property (nonatomic,strong)IWDuiJiangCenterModel *model;

@property (nonatomic,copy) void (^IWDuiJiangCender)();
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
