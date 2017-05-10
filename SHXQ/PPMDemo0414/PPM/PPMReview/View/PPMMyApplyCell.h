//
//  PPMMyApplyCell.h
//  PPM
//
//  Created by lu_ios on 17/4/13.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPMMyApplyCell : UITableViewCell
/**
 *  模型
 */
@property (nonatomic, strong)NSDictionary *modelDic;
/**
 *  隐藏下画线
 */
@property (nonatomic, assign)BOOL hiddenDownLine;
/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
