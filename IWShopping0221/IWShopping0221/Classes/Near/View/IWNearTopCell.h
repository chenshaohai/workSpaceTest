

#import <UIKit/UIKit.h>
#import "IWNearTopModel.h"
#import "IWNearCollectionViewCell.h"
/**
 *  collectionCell点击的block
 *
 *  @param nearTopModel   模型
 *  @param index          序号.从0开始
 */
typedef void(^IWNearCollectionViewCellClick) (IWNearTopModel *nearTopModel,NSInteger index);

@interface IWNearTopCell : UITableViewCell
/**
 *  collectionCell点击的block
 */
@property (nonatomic,copy)IWNearCollectionViewCellClick cellClick;
/**
 *  模型数组
 */
@property (nonatomic, strong)NSArray *modelArray;

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
