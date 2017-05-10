//
//  IWMePersonIconCell.h
//  IWShopping0221
//
//  Created by FRadmin on 17/3/10.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWLoginModel.h"

@interface IWMePersonIconCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  用户模型
 */
@property (nonatomic, strong)IWLoginModel *user;

@end
