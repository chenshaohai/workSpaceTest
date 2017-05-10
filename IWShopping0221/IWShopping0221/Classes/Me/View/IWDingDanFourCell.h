//
//  IWDingDanFourCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWDingDanFourModel.h"

@interface IWDingDanFourCell : UITableViewCell
@property (nonatomic,strong)IWDingDanFourModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
