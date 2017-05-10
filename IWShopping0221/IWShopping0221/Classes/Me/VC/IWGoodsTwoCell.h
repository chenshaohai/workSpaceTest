//
//  IWGoodsTwoCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWGoodTwoModel.h"

@interface IWGoodsTwoCell : UITableViewCell
@property (nonatomic,strong)IWGoodTwoModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
