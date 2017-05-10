//
//  IWDuiJiangCenterCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/9.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDuiJiangCenterCell.h"
#define kLinColor IWColor(240, 240, 240)
#define kFontColor IWColor(57, 57, 57)
#define kMarkColor IWColor(252, 33, 95)
#define kTextFont kFont24px
@interface IWDuiJiangCenterCell ()
// 头像
@property(nonatomic,weak)UIImageView *topImg;
// 名字
@property (nonatomic,weak)UILabel *nameLabel;
// 抽奖日期
@property (nonatomic,weak)UILabel *chouLabel;
// 兑奖日期
@property (nonatomic,weak)UILabel *duiLabel;
// 兑换按钮
@property (nonatomic,weak)UIButton *duiBtn;
// cell白色背景
@property (nonatomic,weak)UIView *cellBack;
// 分割线
@property (nonatomic,weak)UIView *linView;
@end

@implementation IWDuiJiangCenterCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDuiJiangCenterCell"];
    IWDuiJiangCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDuiJiangCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // cell 背景
        UIView *cellBack = [[UIView alloc] init];
        cellBack.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cellBack];
        self.cellBack = cellBack;
        
        // 图片
        UIImageView *topImg = [[UIImageView alloc] init];
        topImg.backgroundColor = [UIColor orangeColor];
        [cellBack addSubview:topImg];
        self.topImg = topImg;
        
        // 名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = kRedColor;
        nameLabel.font = kTextFont;
        [cellBack addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 抽奖日期
        UILabel *chouLabel = [[UILabel alloc] init];
        chouLabel.textColor = kFontColor;
        chouLabel.font = kTextFont;
        [cellBack addSubview:chouLabel];
        self.chouLabel = chouLabel;
        
        // 兑奖日期
        UILabel *duiLabel = [[UILabel alloc] init];
        duiLabel.textColor = kFontColor;
        duiLabel.font = kTextFont;
        [cellBack addSubview:duiLabel];
        self.duiLabel = duiLabel;
        
        // 兑奖按钮
        UIButton *duiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [duiBtn setTitle:@"兑奖" forState:UIControlStateNormal];
        [duiBtn setTitleColor:kMarkColor forState:UIControlStateNormal];
        duiBtn.layer.borderWidth = kFRate(0.5);
        duiBtn.layer.borderColor = kMarkColor.CGColor;
        duiBtn.titleLabel.font = kTextFont;
        duiBtn.layer.cornerRadius = kFRate(3);
        [duiBtn addTarget:self action:@selector(duiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cellBack addSubview:duiBtn];
        self.duiBtn = duiBtn;
        
        UIView *linView = [[UIView alloc] init];
        linView.backgroundColor = kLineColor;
        [cellBack addSubview:linView];
        self.linView = linView;
    }
    return self;
}

- (void)setModel:(IWDuiJiangCenterModel *)model
{
    _model = model;
    
    [_topImg sd_setImageWithURL:[NSURL URLWithString:_model.topImg]];
    _nameLabel.text = _model.name;
    _chouLabel.text = _model.chouJiangDate;
    _duiLabel.text = _model.duiJiangDate;

    NSString *str = @"奖品名称：";
    NSString *string = _model.name;

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRange = NSMakeRange([[attStr string] rangeOfString:str].location, [[attStr string] rangeOfString:str].length);
    [attStr addAttribute:NSForegroundColorAttributeName value:kFontColor range:redRange];
    [_nameLabel setAttributedText:attStr];

    
    // Frame
    _topImg.frame = _model.topImgF;
    _nameLabel.frame = _model.nameF;
    _chouLabel.frame = _model.chouJiangF;
    _duiLabel.frame = _model.duiJiangF;
    _duiBtn.frame = _model.btnF;
    _linView.frame = _model.linF;
    _cellBack.frame = CGRectMake(0, 0, kViewWidth, _model.cellH);
}

#pragma mark - 兑换
- (void)duiBtnClick
{
    if (self.IWDuiJiangCender) {
        self.IWDuiJiangCender();
    }
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
