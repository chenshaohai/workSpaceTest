

#import <UIKit/UIKit.h>
#import "IWShoppingModel.h"
@interface IWShoppingCell : UITableViewCell
/**
 *  模型
 */
@property (nonatomic, strong)IWShoppingModel *model;

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
@property (nonatomic, copy) void (^addBtnClick)(IWShoppingCell *cell);
/**
 * 减少 回调
 */
@property (nonatomic, copy) void (^subBtnClick)(IWShoppingCell *cell);
/**
 * 选中 回调
 */
@property (nonatomic, copy) void (^selectBtnClick)(IWShoppingCell *cell);
/**
 * 删除 回调
 */
@property (nonatomic, copy) void (^crashBtnClick)(IWShoppingCell *cell);

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
