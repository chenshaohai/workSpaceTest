//
//  IWHomeMoreCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeMoreCell.h"

@interface IWHomeMoreCell ()
// 图片
@property (nonatomic,weak)UIImageView *imgView;
// 名字
@property (nonatomic,weak)UILabel *nameLable;
// 价格
@property (nonatomic,weak)UILabel *nowPriceLabel;
// 市场价格
@property (nonatomic,weak)UILabel *allPriceLabel;
// 库存
@property (nonatomic,weak)UILabel *stockLabel;
@end

@implementation IWHomeMoreCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWHomeMoreCell"];
    IWHomeMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWHomeMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(15), kFRate(15), kFRate(90), kFRate(90))];
        [self.contentView addSubview:img];
        self.imgView = img;
        
        CGFloat nameX = CGRectGetMaxX(img.frame) + kFRate(10);
        CGFloat labelW = kViewWidth - nameX - kFRate(20);
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, kFRate(15), labelW, kFRate(13))];
        nameLabel.font = kFont28px;
        [self.contentView addSubview:nameLabel];
        self.nameLable = nameLabel;
        
        UILabel * priceLabel= [[UILabel alloc] init];
        priceLabel.textColor = IWColor(90, 90, 90);
        priceLabel.font = kFont24px;
        priceLabel.text = @"价格：";
        [priceLabel sizeToFit];
        priceLabel.frame = CGRectMake(nameX, kFRate(36), priceLabel.frame.size.width, kFRate(11));
        [self.contentView addSubview:priceLabel];
        
        UILabel * nowPriceLabel= [[UILabel alloc] init];
        nowPriceLabel.textColor = IWColor(252, 76, 112);
        nowPriceLabel.font = kFont24px;
        nowPriceLabel.frame = CGRectMake(CGRectGetMaxX(priceLabel.frame), kFRate(36), labelW - priceLabel.frame.size.width, kFRate(11));
        [self.contentView addSubview:nowPriceLabel];
        self.nowPriceLabel = nowPriceLabel;
        
        // 市场价
        UILabel * allPrice= [[UILabel alloc] init];
        allPrice.textColor = IWColor(90, 90, 90);
        allPrice.font = kFont24px;
        allPrice.text = @"市场价：";
        [allPrice sizeToFit];
        allPrice.frame = CGRectMake(nameX, kFRate(55), allPrice.frame.size.width, kFRate(11));
        [self.contentView addSubview:allPrice];
        
        UILabel * allPriceLabel= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(allPrice.frame), kFRate(55), labelW - allPrice.frame.size.width, kFRate(11))];
        allPriceLabel.textColor = IWColor(190, 190, 190);
        allPriceLabel.font = kFont24px;
        [self.contentView addSubview:allPriceLabel];
        self.allPriceLabel = allPriceLabel;
        
        // 分割线
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(nameX, CGRectGetMaxY(allPriceLabel.frame) + kFRate(10), labelW, kFRate(0.5))];
        linView.backgroundColor = kLineColor;
        [self.contentView addSubview:linView];
        
        // 库存
        UILabel *stockL = [[UILabel alloc] init];
        stockL.text = @"销量：";
        stockL.font = kFont28px;
        [stockL sizeToFit];
        stockL.frame = CGRectMake(nameX, CGRectGetMaxY(linView.frame) + kFRate(10), stockL.frame.size.width, kFRate(13));
        [self.contentView addSubview:stockL];
        
        UILabel * stockLabel= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(stockL.frame), CGRectGetMaxY(linView.frame) + kFRate(10), labelW - stockL.frame.size.width, kFRate(13))];
        stockLabel.textColor = [UIColor grayColor];
        stockLabel.font = kFont28px;
        stockLabel.textColor = IWColor(252, 0, 82);
        [self.contentView addSubview:stockLabel];
        self.stockLabel = stockLabel;
        
        UIView *lastView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(119.5), kViewWidth, kFRate(0.5))];
        lastView.backgroundColor = kLineColor;
        [self.contentView addSubview:lastView];
    }
    return self;
}

- (void)setModel:(IWHomeRegionProductModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageUrl,_model.thumbImg]];
    [self.imgView sd_setImageWithURL:url];
    self.nameLable.text = _model.productName;
    self.nowPriceLabel.text = _model.salePrice;
    // 市场价
    // 已完成标题文字灰色,中间有线条
    NSString *oldPrice = _model.smarketPrice;
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:IWColor(190, 190, 190) range:NSMakeRange(0, length)];
    [self.allPriceLabel setAttributedText:attri];
    self.stockLabel.text = _model.stock;
}

- (void)setMoreMode:(IWHomeMoreModel *)moreMode
{
    _moreMode = moreMode;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageUrl,_moreMode.img]];
    [self.imgView sd_setImageWithURL:url];
    self.nameLable.text = _moreMode.name;
    self.nowPriceLabel.text = _moreMode.price;
    // 市场价
    // 已完成标题文字灰色,中间有线条
    NSString *oldPrice = _moreMode.allPrice;
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:IWColor(190, 190, 190) range:NSMakeRange(0, length)];
    [self.allPriceLabel setAttributedText:attri];
    self.stockLabel.text = _moreMode.stock;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
