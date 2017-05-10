//
//  IWTuiHuanWuLiuCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/29.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWTuiHuanWuLiuModel.h"

@interface IWTuiHuanWuLiuCell : UITableViewCell
@property (nonatomic,strong)IWTuiHuanWuLiuModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
