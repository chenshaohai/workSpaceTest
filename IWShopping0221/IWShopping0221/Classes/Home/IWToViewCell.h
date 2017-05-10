//
//  IWToViewCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/13.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWToViewModel.h"

@interface IWToViewCell : UITableViewCell
// 上线
@property (nonatomic,weak)UIView *linSView;
// 下线
@property (nonatomic,weak)UIView *linXView;
// 图标
@property (nonatomic,weak)UIImageView *imgView;
// 物流内容
@property (nonatomic,weak)UILabel *contentLabel;
// 时间
@property (nonatomic,weak)UILabel *timeLabel;
// 模型
@property (nonatomic,strong)IWToViewModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
