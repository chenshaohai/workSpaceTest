//
//  IWRecordCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/6.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWRecordCell.h"

@interface IWRecordCell ()
// 店名
@property (nonatomic,weak)UILabel *storeLabel;
// 头像
@property (nonatomic,weak)UIImageView *topImg;
// 订单
@property (nonatomic,weak)UILabel *orderLabel;
@property (nonatomic,weak)UILabel *orderNumLable;
// 下单时间
@property (nonatomic,weak)UILabel *timeLabel;
@property (nonatomic,weak)UILabel *orderTimeLabel;
// 支付
@property (nonatomic,weak)UILabel *payLabel;
@property (nonatomic,weak)UILabel *payNumLabel;
// 支付方式
@property (nonatomic,weak)UILabel *wayLabel;
@property (nonatomic,weak)UILabel *payWayLabel;
// 分割线
@property (nonatomic,weak)UIView *linOne;
@property (nonatomic,weak)UIView *linTwo;
// cell背景
@property (nonatomic,weak)UIView *cellBack;

@end

@implementation IWRecordCell

#define kFontColor IWColor(103, 103, 103)
#define kLinColor IWColor(240, 240, 240)

+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWRecordCell"];
    IWRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *cellBack = [[UIView alloc] init];
        cellBack.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cellBack];
        self.cellBack = cellBack;
        
        // 店名
        UILabel *storeLabel = [[UILabel alloc] init];
        storeLabel.textColor = kFontColor;
        storeLabel.font = kFont24px;
        [cellBack addSubview:storeLabel];
        self.storeLabel = storeLabel;
        
        UIView *linOne = [[UIView alloc] init];
        linOne.backgroundColor = kLineColor;
        [cellBack addSubview:linOne];
        self.linOne = linOne;
        
        // 头像
        UIImageView *topImg = [[UIImageView alloc] init];
        topImg.backgroundColor = [UIColor lightGrayColor];
        [cellBack addSubview:topImg];
        self.topImg = topImg;
        
        // 订单
        UILabel *orderLabel = [[UILabel alloc] init];
        orderLabel.textColor = kFontColor;
        orderLabel.font = kFont24px;
        [cellBack addSubview:orderLabel];
        self.orderLabel = orderLabel;
        
        UILabel *orderNumLable = [[UILabel alloc] init];
        orderNumLable.textColor = kFontColor;
        orderNumLable.font = kFont24px;
        [cellBack addSubview:orderNumLable];
        self.orderNumLable = orderNumLable;
        
        // 下单时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = kFontColor;
        timeLabel.font = kFont24px;
        [cellBack addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *orderTimeLabel = [[UILabel alloc] init];
        orderTimeLabel.textColor = kFontColor;
        orderTimeLabel.font = kFont24px;
        [cellBack addSubview:orderTimeLabel];
        self.orderTimeLabel = orderTimeLabel;
        
        // 支付
        UILabel *payLabel = [[UILabel alloc] init];
        payLabel.textColor = kFontColor;
        payLabel.font = kFont24px;
        [cellBack addSubview:payLabel];
        self.payLabel = payLabel;
        
        UILabel *payNumLabel = [[UILabel alloc] init];
        payNumLabel.textColor = kFontColor;
        payNumLabel.font = kFont24px;
        [cellBack addSubview:payNumLabel];
        self.payNumLabel = payNumLabel;
        
        UIView *linTwo = [[UIView alloc] init];
        linTwo.backgroundColor = kLineColor;
        [cellBack addSubview:linTwo];
        self.linTwo = linTwo;
        
        // 支付方式
        UILabel *wayLabel = [[UILabel alloc] init];
        wayLabel.textColor = kFontColor;
        wayLabel.font = kFont24px;
        [cellBack addSubview:wayLabel];
        self.wayLabel = wayLabel;
        
        UILabel *payWayLabel = [[UILabel alloc] init];
        payWayLabel.textColor = IWColor(252, 0, 86);
        payWayLabel.font = kFont24px;
        [cellBack addSubview:payWayLabel];
        self.payWayLabel = payWayLabel;
    }
    return self;
}

- (void)setModel:(IWRecordModel *)model
{
    _model = model;
    _storeLabel.text = _model.storeName;
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",kImageUrl,model.topImg]];
    [_topImg sd_setImageWithURL:url];
    _orderLabel.text = _model.order;
    _orderNumLable.text = _model.orderNum;
    _timeLabel.text = _model.time;
    _orderTimeLabel.text = _model.orderTime;
    _payLabel.text = _model.pay;
    _payNumLabel.text = _model.payNum;
    _wayLabel.text = _model.way;
    _payWayLabel.text = _model.payWay;
    
    _cellBack.frame = CGRectMake(0, kFRate(5), kViewWidth, _model.cellH - kFRate(5));
    _storeLabel.frame = _model.storeNameF;
    _topImg.frame = _model.topImgF;
    _orderLabel.frame = _model.orderF;
    _orderNumLable.frame = _model.orderNumF;
    _timeLabel.frame = _model.timeF;
    _orderTimeLabel.frame = _model.orderTimeF;
    _payLabel.frame = _model.payF;
    _payNumLabel.frame = _model.payNumF;
    _wayLabel.frame = _model.wayF;
    _payWayLabel.frame = _model.payWayF;
    _linOne.frame = _model.linOneF;
    _linTwo.frame = _model.linTwoF;
    
    
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
