//
//  IWGoodsTwoCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGoodsTwoCell.h"
// 字体颜色
#define kNameColor IWColor(50, 50, 50)
#define kContentColor IWColor(160, 160, 160)

@interface IWGoodsTwoCell ()
// 标题
@property (nonatomic,weak)UILabel *orderContent;
// 标题背景
@property (nonatomic,weak)UIView *orderBack;
// 分割线
@property (nonatomic,weak)UIView *linOneView;
@property (nonatomic,weak)UIView *linTwoView;
@property (nonatomic,weak)UIView *linThreeView;
// 图片
@property (nonatomic,weak)UIImageView *topImg;
// 名字
@property (nonatomic,weak)UILabel *nameLabel;
// 规格
@property (nonatomic,weak)UILabel *skuLabel;
// 价格
@property (nonatomic,weak)UILabel *priceLabel;
// 数量
@property (nonatomic,weak)UILabel *shopNumLabel;

// 商铺图标
@property (nonatomic,weak)UIImageView *shopImg;
// 状态
@property (nonatomic,weak)UILabel *stateLabel;

// cell背景
@property (nonatomic,weak)UIView *cellBack;
@end

@implementation IWGoodsTwoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDingDanThreeCell"];
    IWGoodsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWGoodsTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 背景
        UIView *cellBack = [[UIView alloc] init];
        cellBack.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cellBack];
        self.cellBack = cellBack;
        
        UIView *orderBack = [[UIView alloc] init];
        orderBack.backgroundColor = IWColor(250, 250, 250);
        [cellBack addSubview:orderBack];
        self.orderBack = orderBack;
        
        // 图标
        UIImageView *shopImg = [[UIImageView alloc] init];
        shopImg.image = _IMG(@"IWDianpu");
        [orderBack addSubview:shopImg];
        self.shopImg = shopImg;
        
        // 标题
        UILabel *orderContent = [[UILabel alloc] init];
        orderContent.font = kFont28px;
        [orderBack addSubview:orderContent];
        self.orderContent = orderContent;
        
        // 分割线
        UIView *linOneView = [[UIView alloc] init];
        linOneView.backgroundColor = kLineColor;
        [cellBack addSubview:linOneView];
        self.linOneView = linOneView;
        
        UIView *linTwoView = [[UIView alloc] init];
        linTwoView.backgroundColor = kLineColor;
        [cellBack addSubview:linTwoView];
        self.linTwoView = linTwoView;
        
        UIView *linThreeView = [[UIView alloc] init];
        linThreeView.backgroundColor = kLineColor;
        [cellBack addSubview:linThreeView];
        self.linThreeView = linThreeView;
        
        // 图片
        UIImageView *topImg = [[UIImageView alloc] init];
        topImg.backgroundColor = [UIColor lightGrayColor];
        [cellBack addSubview:topImg];
        self.topImg = topImg;
        
        // 名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kFont24px;
        nameLabel.numberOfLines = 0;
        [cellBack addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 规格
        UILabel *skuLabel = [[UILabel alloc] init];
        skuLabel.font = kFont24px;
        skuLabel.textColor = kContentColor;
        skuLabel.numberOfLines = 0;
        [cellBack addSubview:skuLabel];
        self.skuLabel = skuLabel;
        
        // 价格
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.font = kFont24px;
        priceLabel.textColor = kRedColor;
        [cellBack addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        // 数量
        UILabel *shopNumLabel = [[UILabel alloc] init];
        shopNumLabel.font = kFont24px;
        shopNumLabel.textColor = kContentColor;
        shopNumLabel.textAlignment = NSTextAlignmentRight;
        [cellBack addSubview:shopNumLabel];
        self.shopNumLabel = shopNumLabel;
        
        // 状态
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.font = kFont24px;
        stateLabel.textAlignment = NSTextAlignmentRight;
        [cellBack addSubview:stateLabel];
        self.stateLabel = stateLabel;
    }
    return self;
}

- (void)setModel:(IWGoodTwoModel *)model
{
    _model = model;
    _orderContent.text = _model.shopName;
    [_topImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageUrl,_model.goodsImg]]];
    _nameLabel.text = _model.goodsName;
    _skuLabel.text = _model.goodsSku;
    _priceLabel.text = _model.goodsPrice;
    _shopNumLabel.text = _model.shopNum;
    _stateLabel.text = _model.shopState;
    
    // frame
    _cellBack.frame = CGRectMake(0, 0, kViewWidth, _model.cellH - kFRate(10));
    _orderBack.frame = _model.tableThreeF;
    _orderContent.frame = _model.shopNameF;
    _topImg.frame = _model.goodsImgF;
    _nameLabel.frame = _model.goodsNameF;
    _skuLabel.frame = _model.goodsSkuF;
    _priceLabel.frame = _model.goodsPriceF;
    _shopNumLabel.frame = _model.shopNumF;
    _shopImg.frame = _model.shopImgF;
    _stateLabel.frame = _model.shopStateF;
    
    _linOneView.frame = _model.linThreeF;
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
