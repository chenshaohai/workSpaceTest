//
//  IWAddressCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/8.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWAddressModel.h"

@interface IWAddressCell : UITableViewCell
// 默认按钮
@property (nonatomic,weak)UIButton *selectBtn;
// 模型
@property (nonatomic,strong)IWAddressModel *model;
// 初始化cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

// block
// 编辑
@property (nonatomic, copy) void (^IWAddressCellEdit)();
// 删除
@property (nonatomic, copy) void (^IWAddressCellDelete)();
// 选择默认地址
@property (nonatomic, copy) void (^IWAddressCellChange)();
@end
