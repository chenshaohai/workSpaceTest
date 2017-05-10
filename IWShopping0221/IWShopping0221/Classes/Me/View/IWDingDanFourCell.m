//
//  IWDingDanFourCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDingDanFourCell.h"
// 字体颜色
#define kNameColor IWColor(50, 50, 50)
#define kContentColor IWColor(160, 160, 160)

@interface IWDingDanFourCell ()
// 标题
@property (nonatomic,weak)UILabel *orderContent;
// 标题背景
@property (nonatomic,weak)UIView *orderBack;
// 分割线
@property (nonatomic,weak)UIView *linView;
// 订单总金额
@property (nonatomic,weak)UILabel *numberLabel;
@property (nonatomic,weak)UILabel *orderNumLabel;
// 运费
@property (nonatomic,weak)UILabel *timeLabel;
@property (nonatomic,weak)UILabel *createTimeLabel;
// 会币抵扣
@property (nonatomic,weak)UILabel *stateLabel;
@property (nonatomic,weak)UILabel *orderStateLabel;

// cell背景
@property (nonatomic,weak)UIView *cellBack;
@end

@implementation IWDingDanFourCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDingDanFourCell"];
    IWDingDanFourCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDingDanFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        
        // 订单总金额
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.textColor = kNameColor;
        numberLabel.font = kFont24px;
        [cellBack addSubview:numberLabel];
        self.numberLabel = numberLabel;
        
        UILabel *orderNumLabel = [[UILabel alloc] init];
        orderNumLabel.textColor = kNameColor;
        orderNumLabel.font = kFont24px;
        orderNumLabel.textAlignment = NSTextAlignmentRight;
        [cellBack addSubview:orderNumLabel];
        self.orderNumLabel = orderNumLabel;
        
        // 运费
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = kNameColor;
        timeLabel.font = kFont24px;
        [cellBack addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *createTimeLabel = [[UILabel alloc] init];
        createTimeLabel.textColor = kNameColor;
        createTimeLabel.font = kFont24px;
        createTimeLabel.textAlignment = NSTextAlignmentRight;
        [cellBack addSubview:createTimeLabel];
        self.createTimeLabel = createTimeLabel;
        
        // 会币抵扣
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.textColor = kNameColor;
        stateLabel.font = kFont24px;
        [cellBack addSubview:stateLabel];
        self.stateLabel = stateLabel;
        
        UILabel *orderStateLabel = [[UILabel alloc] init];
        orderStateLabel.textColor = kNameColor;
        orderStateLabel.font = kFont24px;
        orderStateLabel.textAlignment = NSTextAlignmentRight;
        [cellBack addSubview:orderStateLabel];
        self.orderStateLabel = orderStateLabel;
        
    }
    return self;
}

- (void)setModel:(IWDingDanFourModel *)model
{
    _model = model;
    _orderContent.text = _model.orderSum;
    _numberLabel.text = _model.total;
    _orderNumLabel.text = _model.orderTotal;
    _timeLabel.text = _model.yunFei;
    _createTimeLabel.text = _model.freight;
    _stateLabel.text = _model.zheKou;
    _orderStateLabel.text = _model.discount;
    
    // Frame
    _orderBack.frame = _model.tableFourF;
    _orderContent.frame = _model.orderSumF;
    _numberLabel.frame = _model.totalF;
    _orderNumLabel.frame = _model.orderTotalF;
    _timeLabel.frame = _model.yuFeiF;
    _createTimeLabel.frame = _model.freightF;
    _stateLabel.frame = _model.zheKouF;
    _orderStateLabel.frame = _model.discountF;
    _linView.frame = _model.linFourF;
    
    _cellBack.frame = CGRectMake(0, 0, kViewWidth, _model.cellH);
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
