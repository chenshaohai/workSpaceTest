//
//  IWHomeMoreCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWHomeRegionProductModel.h"
#import "IWHomeMoreModel.h"

@interface IWHomeMoreCell : UITableViewCell
// 模型
@property (nonatomic,strong)IWHomeRegionProductModel *model;
@property (nonatomic,strong)IWHomeMoreModel *moreMode;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
