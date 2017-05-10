//
//  PPMProjectDetailCell.h
//  PPM
//
//  Created by lu_ios on 17/4/14.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMProjectDetailModel.h"
@interface PPMProjectDetailCell : UITableViewCell
/**
 *  模型
 */
@property (nonatomic, strong)PPMProjectDetailModel *model;

/**
 *  隐藏下画线
 */
@property (nonatomic, assign)BOOL hiddenDownLine;
/**
 *  是否显示底部文字
 */
@property(nonatomic,assign)BOOL showDetailText;
/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
