//
//  IWHomeCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/22.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeCell.h"
#import "IWHomeCellBtn.h"

@interface IWHomeCell ()
// 图
@property (nonatomic,weak)UIImageView *itemImg;
// 文字
@property (nonatomic,weak)UILabel *nameLabel;
// 销售价格
@property (nonatomic,weak)UILabel *praceLabel;
@end

@implementation IWHomeCell
- (instancetype)cellWithTableView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    NSString *ID = [NSString stringWithFormat:@"IWHomeCell"];
    IWHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


- (void)setProductModel:(IWHomeRegionProductModel *)productModel
{
    _productModel = productModel;
    [self.itemImg removeFromSuperview];
    [self.nameLabel removeFromSuperview];
    [self.praceLabel removeFromSuperview];
    
    UIImageView *itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRate(93), kRate(93))];
    NSString *imgTop = [NSString stringWithFormat:@"%@%@",kImageUrl,_productModel.thumbImg];
    NSURL *url = [NSURL URLWithString:imgTop];
    [itemImg sd_setImageWithURL:url placeholderImage:_IMG(@"")];
    [self.contentView addSubview:itemImg];
    self.itemImg = itemImg;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRate(93), kRate(93), kRate(30))];
    nameLabel.font = kFont24px;
    nameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
    nameLabel.text = _productModel.productName;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 销售价
    UILabel *praceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame), kRate(93), kFRate(40))];
    praceLabel.font = kFont28px;
    praceLabel.textColor = kRedColor;
    praceLabel.numberOfLines = 2;
    // ￥
    CGFloat showPriceF = [_productModel.salePrice floatValue];
    CGFloat integralF = [_productModel.integral floatValue];
    praceLabel.text = [NSString stringWithFormat:@"￥%.2f+%.0f贝壳",showPriceF,integralF];
    praceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:praceLabel];
    self.praceLabel = praceLabel;
}

@end
