//
//  IWDingDanTwoCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWDingDanTwoModel.h"

@interface IWDingDanTwoCell : UITableViewCell
@property (nonatomic,strong)IWDingDanTwoModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
