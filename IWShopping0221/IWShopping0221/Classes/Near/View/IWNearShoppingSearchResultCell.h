//
//  IWNearShoppingSearchResultCell.h
//  IWShopping0221
//
//  Created by s on 17/2/24.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWNearShoppingModel.h"
@interface IWNearShoppingSearchResultCell : UITableViewCell
/**
 *  模型
 */
@property (nonatomic, strong)IWNearShoppingModel *model;

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

