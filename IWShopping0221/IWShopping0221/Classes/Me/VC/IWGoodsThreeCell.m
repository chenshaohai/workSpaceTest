//
//  IWGoodsThreeCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGoodsThreeCell.h"

@interface IWGoodsThreeCell ()
// 标题
@property (nonatomic,weak)UILabel *orderContent;
// 标题背景
@property (nonatomic,weak)UIView *orderBack;
// 分割线
@property (nonatomic,weak)UIView *linView;
// 原因
@property (nonatomic,weak)UILabel *tempLabel;


// cell背景
@property (nonatomic,weak)UIView *cellBack;
@end

@implementation IWGoodsThreeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWGoodsThreeCell"];
    IWGoodsThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWGoodsThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = kFont24px;
        [cellBack addSubview:contentLabel];
        self.tempLabel = contentLabel;
        
    }
    return self;
}

- (void)setModel:(IWGoodsThreeModel *)model
{
    _model = model;
    _orderContent.text = _model.orderContent;
    _tempLabel.text = _model.content;

    
    // Frame
    _orderBack.frame = _model.tableOneF;
    _orderContent.frame = _model.orderContentF;
    _tempLabel.frame = _model.contentF;
    _linView.frame = _model.linOneF;
    
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
