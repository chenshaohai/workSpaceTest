//
//  IWMeOrderFormCell.h
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWMeOrderFormProductModel.h"
@interface IWMeOrderFormCell : UITableViewCell
/**
 *  模型
 */
@property (nonatomic, strong)IWMeOrderFormProductModel *model;

/**
 *  编辑
 */
@property (nonatomic, assign)BOOL isCellEdit;

/**
 *
 */
//@property (nonatomic, strong)UITableView *tableView;

/**
 *
 */
//@property (nonatomic, strong)NSIndexPath *indexPath;
/**
 * 添加 回调
 */
@property (nonatomic, copy) void (^addBtnClick)(IWMeOrderFormCell *cell);
/**
 * 减少 回调
 */
@property (nonatomic, copy) void (^subBtnClick)(IWMeOrderFormCell *cell);
/**
 * 选中 回调
 */
@property (nonatomic, copy) void (^selectBtnClick)(IWMeOrderFormCell *cell);
/**
 * 删除 回调
 */
@property (nonatomic, copy) void (^crashBtnClick)(IWMeOrderFormCell *cell);

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
