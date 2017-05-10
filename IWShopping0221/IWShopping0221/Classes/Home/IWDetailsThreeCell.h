//
//  IWDetailsThreeCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWDetailModel.h"

@interface IWDetailsThreeCell : UITableViewCell
// 模型
@property (nonatomic,strong)IWDetailModel *detailModel;
@property (nonatomic,weak)UIWebView *webView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
