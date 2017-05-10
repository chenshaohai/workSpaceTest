//
//  IWGategoryCell.m
//  IWShopping0221
//
//  Created by admin on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGategoryCell.h"

@interface IWGategoryCell ()
// 图
@property (nonatomic,weak)UIImageView *itemImg;
// 文字
@property (nonatomic,weak)UILabel *nameLabel;

@end

@implementation IWGategoryCell
- (instancetype)cellWithTableView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    NSString *ID = [NSString stringWithFormat:@"IWDetailsGategoryCell"];
    IWGategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)setModel:(IWGategoryThreeModel *)model
{
    _model = model;
    [self.itemImg removeFromSuperview];
    [self.nameLabel removeFromSuperview];
    
    UIImageView *itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRate(90), kRate(90))];
    NSString *imgTop = [NSString stringWithFormat:@"%@%@",kImageUrl,_model.cateIconImg];
    NSURL *url = [NSURL URLWithString:imgTop];
    [itemImg sd_setImageWithURL:url placeholderImage:_IMG(@"")];
    [self.contentView addSubview:itemImg];
    self.itemImg = itemImg;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRate(90), kRate(90), kRate(30))];
    nameLabel.font = kFont24px;
    nameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
    nameLabel.text = _model.cateName;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
}

- (void)setProductModel:(IWHomeRegionProductModel *)productModel
{
    _productModel = productModel;
    [self.itemImg removeFromSuperview];
    [self.nameLabel removeFromSuperview];
    
    UIImageView *itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRate(90), kRate(90))];
    NSString *imgTop = [NSString stringWithFormat:@"%@%@",kImageUrl,_productModel.thumbImg];
    NSURL *url = [NSURL URLWithString:imgTop];
    [itemImg sd_setImageWithURL:url placeholderImage:_IMG(@"")];
    [self.contentView addSubview:itemImg];
    self.itemImg = itemImg;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRate(90), kRate(90), kRate(30))];
    nameLabel.font = kFont24px;
    nameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
    nameLabel.text = productModel.productName;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.numberOfLines = 2;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

@end
