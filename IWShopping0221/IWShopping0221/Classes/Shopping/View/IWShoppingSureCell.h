//
//  IWShoppingSureCell.h
//  IWShopping0221
//
//  Created by s on 17/3/15.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWShoppingModel.h"
@interface IWShoppingSureCell : UITableViewCell

/**
 *  模型
 */
@property (nonatomic, strong)IWShoppingModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
