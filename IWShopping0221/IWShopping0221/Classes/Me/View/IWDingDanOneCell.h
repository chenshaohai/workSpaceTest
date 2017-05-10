//
//  IWDingDanOneCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWDingDanOneModel.h"

@interface IWDingDanOneCell : UITableViewCell
@property (nonatomic,strong)IWDingDanOneModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
