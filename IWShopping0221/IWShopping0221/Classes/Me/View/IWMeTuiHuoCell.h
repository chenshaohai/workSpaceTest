//
//  IWMeTuiHuoCell.h
//  IWShopping0221
//
//  Created by s on 17/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWMeOrderFormProductModel.h"
@interface IWMeTuiHuoCell : UITableViewCell
/**
 *  模型
 */
@property (nonatomic, strong)IWMeOrderFormProductModel *model;
/**
 * 添加 回调
 */
@property (nonatomic, copy) void (^addBtnClick)(IWMeTuiHuoCell *cell);
/**
 * 减少 回调
 */
@property (nonatomic, copy) void (^subBtnClick)(IWMeTuiHuoCell *cell);

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
