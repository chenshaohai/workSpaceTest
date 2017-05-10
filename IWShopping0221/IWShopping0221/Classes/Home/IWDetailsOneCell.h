//
//  IWDetailsOneCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/25.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWDetailsModel.h"

@interface IWDetailsOneCell : UITableViewCell
// 模型
@property (nonatomic,strong)IWDetailsModel *detailsModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
