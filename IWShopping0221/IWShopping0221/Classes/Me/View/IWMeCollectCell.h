//
//  IWMeCollectCell.h
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWMeCollectModel.h"
@interface IWMeCollectCell : UITableViewCell
// 模型
@property (nonatomic,strong)IWMeCollectModel *model;

/**
 * 删除 回调
 */
@property (nonatomic, copy) void (^crashBtnClick)(IWMeCollectModel *model);
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
