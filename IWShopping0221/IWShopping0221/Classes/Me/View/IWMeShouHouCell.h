//
//  IWMeShouHouCell.h
//  IWShopping0221
//
//  Created by s on 17/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "IWMeOrderFormProductModel.h"

#import "IWMeShouHouModel.h"
@interface IWMeShouHouCell : UITableViewCell
/**
 *  模型
 */
@property (nonatomic, strong)IWMeShouHouModel *model;



/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
