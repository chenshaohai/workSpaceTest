

#import <UIKit/UIKit.h>
#import "IWNearShoppingModel.h"
@interface IWNearShoppingCell : UITableViewCell
/**
 *  模型
 */
@property (nonatomic, strong)IWNearShoppingModel *model;

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
