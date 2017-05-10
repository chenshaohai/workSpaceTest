//
//  IWNearShoppingDetailDiscussCell.h
//  IWShopping0221
//
//  Created by s on 17/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWNearShoppingDetailDiscussModel.h"

@interface IWNearShoppingDetailDiscussCell : UITableViewCell

/**
 *  模型
 */
@property (nonatomic, strong)IWNearShoppingDetailDiscussModel *model;


/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
