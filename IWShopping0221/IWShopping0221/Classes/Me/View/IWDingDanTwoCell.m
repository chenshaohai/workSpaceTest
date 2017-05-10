//
//  IWDingDanTwoCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDingDanTwoCell.h"
// 字体颜色
#define kNameColor IWColor(50, 50, 50)
#define kContentColor IWColor(160, 160, 160)

@interface IWDingDanTwoCell ()
// 标题
@property (nonatomic,weak)UILabel *orderContent;
// 标题背景
@property (nonatomic,weak)UIView *orderBack;
// 分割线
@property (nonatomic,weak)UIView *linView;
// 收货人
@property (nonatomic,weak)UILabel *numberLabel;
@property (nonatomic,weak)UILabel *orderNumLabel;
// 电话
@property (nonatomic,weak)UILabel *timeLabel;
@property (nonatomic,weak)UILabel *createTimeLabel;
// 收货地址
@property (nonatomic,weak)UILabel *stateLabel;
@property (nonatomic,weak)UILabel *orderStateLabel;

// cell背景
@property (nonatomic,weak)UIView *cellBack;
@end

@implementation IWDingDanTwoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDingDanTwoCell"];
    IWDingDanTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDingDanTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        UIView *linView = [[UIView alloc] init];
        linView.backgroundColor = kLineColor;
        [cellBack addSubview:linView];
        self.linView = linView;
        
        // 订单号
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.textColor = kNameColor;
        numberLabel.font = kFont24px;
        [cellBack addSubview:numberLabel];
        self.numberLabel = numberLabel;
        
        UILabel *orderNumLabel = [[UILabel alloc] init];
        orderNumLabel.textColor = kContentColor;
        orderNumLabel.font = kFont24px;
        [cellBack addSubview:orderNumLabel];
        self.orderNumLabel = orderNumLabel;
        
        // 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = kNameColor;
        timeLabel.font = kFont24px;
        [cellBack addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *createTimeLabel = [[UILabel alloc] init];
        createTimeLabel.textColor = kContentColor;
        createTimeLabel.font = kFont24px;
        [cellBack addSubview:createTimeLabel];
        self.createTimeLabel = createTimeLabel;
        
        // 订单状态
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.textColor = kNameColor;
        stateLabel.font = kFont24px;
        [cellBack addSubview:stateLabel];
        self.stateLabel = stateLabel;
        
        UILabel *orderStateLabel = [[UILabel alloc] init];
        orderStateLabel.textColor = kContentColor;
        orderStateLabel.font = kFont24px;
        orderStateLabel.numberOfLines = 0;
        [cellBack addSubview:orderStateLabel];
        self.orderStateLabel = orderStateLabel;
        
    }
    return self;
}

- (void)setModel:(IWDingDanTwoModel *)model
{
    _model = model;
    _orderContent.text = _model.consigneeMsg;
    _numberLabel.text = _model.name;
    _orderNumLabel.text = _model.consigneeName;
    _timeLabel.text = _model.ph;
    _createTimeLabel.text = _model.phone;
    _stateLabel.text = _model.address;
    _orderStateLabel.text = _model.consigneeAdd;
    
    // Frame
    _orderBack.frame = _model.tableTwoF;
    _orderContent.frame = _model.consigneeMsgF;
    _numberLabel.frame = _model.nameF;
    _orderNumLabel.frame = _model.consigneeNameF;
    _timeLabel.frame = _model.phF;
    _createTimeLabel.frame = _model.phoneF;
    _stateLabel.frame = _model.addF;
    _orderStateLabel.frame = _model.consigneeAddF;
    
    _linView.frame = _model.linTwoF;
    
    _cellBack.frame = CGRectMake(0, 0, kViewWidth, _model.cellH - kFRate(10));
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
