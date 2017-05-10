//
//  IWGoodsOneCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGoodsOneCell.h"
// 字体颜色
#define kNameColor IWColor(50, 50, 50)
#define kContentColor IWColor(160, 160, 160)

@interface IWGoodsOneCell ()
// 标题
@property (nonatomic,weak)UILabel *orderContent;
// 标题背景
@property (nonatomic,weak)UIView *orderBack;
// 分割线
@property (nonatomic,weak)UIView *linView;
// 编号
@property (nonatomic,weak)UILabel *numberLabel;
@property (nonatomic,weak)UILabel *orderNumLabel;
// 时间
@property (nonatomic,weak)UILabel *timeLabel;
@property (nonatomic,weak)UILabel *createTimeLabel;
// 状态
@property (nonatomic,weak)UILabel *stateLabel;
@property (nonatomic,weak)UILabel *orderStateLabel;

// cell背景
@property (nonatomic,weak)UIView *cellBack;
@end

@implementation IWGoodsOneCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWGoodsOneCell"];
    IWGoodsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWGoodsOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        orderStateLabel.textColor = kRedColor;
        orderStateLabel.font = kFont24px;
        [cellBack addSubview:orderStateLabel];
        self.orderStateLabel = orderStateLabel;
        
    }
    return self;
}

- (void)setModel:(IWReturnGoodsModel *)model
{
    _model = model;
    _orderContent.text = _model.orderContent;
    _numberLabel.text = _model.number;
    _orderNumLabel.text = _model.orderNum;
    _timeLabel.text = _model.time;
    _createTimeLabel.text = _model.createTime;
    _stateLabel.text = _model.state;
    _orderStateLabel.text = _model.orderState;
    
    // Frame
    _orderBack.frame = _model.tableOneF;
    _orderContent.frame = _model.orderContentF;
    _numberLabel.frame = _model.numF;
    _orderNumLabel.frame = _model.orderNumF;
    _timeLabel.frame = _model.timeF;
    _createTimeLabel.frame = _model.createTimeF;
    _stateLabel.frame = _model.stateF;
    _orderStateLabel.frame = _model.orderStateF;
    _linView.frame = _model.linOneF;
    
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
