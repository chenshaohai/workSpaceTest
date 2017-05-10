//
//  IWAddShoopNumCell.h
//  IWShopping0221
//
//  Created by admin on 2017/3/15.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWAddShoopNumCell : UITableViewCell
@property (nonatomic,copy) void (^IWAddShopNum)(NSInteger shopNum);
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
