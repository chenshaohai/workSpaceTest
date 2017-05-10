//
//  IWBillCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWBillModel.h"

@interface IWBillCell : UITableViewCell
@property (nonatomic,strong)IWBillModel *model;
// 查看详情按钮
@property (nonatomic,weak)UIControl *contentBtn;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
