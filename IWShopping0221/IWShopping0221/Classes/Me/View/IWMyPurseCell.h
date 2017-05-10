//
//  IWMyPurseCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/3.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWMypurseModel.h"

@interface IWMyPurseCell : UITableViewCell
@property (nonatomic,strong)IWMypurseModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
