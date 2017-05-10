//
//  IWHomeCell.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/22.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWHomeRegionModel.h"
#import "IWHomeRegionProductModel.h"

@interface IWHomeCell : UICollectionViewCell
// 模型
@property (nonatomic,strong)IWHomeRegionProductModel *productModel;

- (instancetype)cellWithTableView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
