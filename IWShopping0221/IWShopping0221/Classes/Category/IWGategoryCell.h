//
//  IWGategoryCell.h
//  IWShopping0221
//
//  Created by admin on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWGategoryThreeModel.h"
#import "IWHomeRegionProductModel.h"

@interface IWGategoryCell : UICollectionViewCell
// 模型
@property (nonatomic,strong)IWGategoryThreeModel *model;
@property (nonatomic,strong)IWHomeRegionProductModel *productModel;
- (instancetype)cellWithTableView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
