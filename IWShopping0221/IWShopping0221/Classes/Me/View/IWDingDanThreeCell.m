//
//  IWDingDanThreeCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDingDanThreeCell.h"
// 字体颜色
#define kNameColor IWColor(50, 50, 50)
#define kContentColor IWColor(160, 160, 160)
@interface IWDingDanThreeCell ()
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
// 配送方式
@property (nonatomic,weak)UILabel *peiSongLabel;
@property (nonatomic,weak)UILabel *distributionLabel;
// 支付方式
@property (nonatomic,weak)UILabel *wayLabel;
@property (nonatomic,weak)UILabel *payWayLabel;
// cell背景
@property (nonatomic,weak)UIView *cellBack;

@end

@implementation IWDingDanThreeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDingDanThreeCell"];
    IWDingDanThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDingDanThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        
        // 配送方式
        UILabel *peiSongLabel = [[UILabel alloc] init];
        peiSongLabel.font = kFont24px;
        peiSongLabel.textColor = kNameColor;
        [cellBack addSubview:peiSongLabel];
        self.peiSongLabel = peiSongLabel;
        
        UILabel *distributionLabel = [[UILabel alloc] init];
        distributionLabel.font = kFont24px;
        distributionLabel.textColor = kContentColor;
        distributionLabel.textAlignment = NSTextAlignmentRight;
        [cellBack addSubview:distributionLabel];
        self.distributionLabel = distributionLabel;
        
        // 支付方式
        UILabel *wayLabel = [[UILabel alloc] init];
        wayLabel.font = kFont24px;
        wayLabel.textColor = kNameColor;
        [cellBack addSubview:wayLabel];
        self.wayLabel = wayLabel;
        
        UILabel *payWayLabel = [[UILabel alloc] init];
        payWayLabel.font = kFont24px;
        payWayLabel.textColor = kContentColor;
        payWayLabel.textAlignment = NSTextAlignmentRight;
        [cellBack addSubview:payWayLabel];
        self.payWayLabel = payWayLabel;
        
    }
    return self;
}

- (void)setModel:(IWDingDanThreeModel *)model
{
    _model = model;
    _orderContent.text = _model.shopName;
    [_topImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageUrl,_model.goodsImg]]];
    _nameLabel.text = _model.goodsName;
    _skuLabel.text = _model.goodsSku;
    _priceLabel.text = _model.goodsPrice;
    _shopNumLabel.text = _model.shopNum;
    _peiSongLabel.text = _model.peiSong;
    _distributionLabel.text = _model.distribution;
    _wayLabel.text = _model.way;
    _payWayLabel.text = _model.payWay;
    _shopNumLabel.text = _model.shopNum;
    
    // frame
    _cellBack.frame = CGRectMake(0, 0, kViewWidth, _model.cellH);
    _orderBack.frame = _model.tableThreeF;
    _orderContent.frame = _model.shopNameF;
    _topImg.frame = _model.goodsImgF;
    _nameLabel.frame = _model.goodsNameF;
    _skuLabel.frame = _model.goodsSkuF;
    _priceLabel.frame = _model.goodsPriceF;
    _shopNumLabel.frame = _model.shopNumF;
    _peiSongLabel.frame = _model.peiSongF;
    _distributionLabel.frame = _model.distributionF;
    _wayLabel.frame = _model.wayF;
    _payWayLabel.frame = _model.payWayF;
    _shopNumLabel.frame = _model.shopNumF;
    _linOneView.frame = _model.linThreeF;
    _linTwoView.frame = _model.linFiveF;
    _linThreeView.frame = _model.linSixF;
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
