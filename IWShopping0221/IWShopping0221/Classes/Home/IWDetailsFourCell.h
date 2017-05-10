//
//  IWDetailsFourCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWCommentModel.h"

@interface IWDetailsFourCell : UITableViewCell
// 模型
@property (nonatomic,strong)IWCommentModel *commentModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
