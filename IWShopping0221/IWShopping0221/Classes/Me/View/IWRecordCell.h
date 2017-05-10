//
//  IWRecordCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/6.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWRecordModel.h"

@interface IWRecordCell : UITableViewCell
@property (nonatomic,strong)IWRecordModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
