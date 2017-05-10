//
//  IWAddShoopNumCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/15.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWAddShoopNumCell.h"

@interface IWAddShoopNumCell ()
// 数量
@property (nonatomic,weak)UILabel *shoopNumLabel;
// 减
@property (nonatomic,weak)UIButton *minusBtn;
// 加
@property (nonatomic,weak)UIButton *addBtn;
// 购买数量
@property (nonatomic,assign)NSInteger shoopNum;
@end

@implementation IWAddShoopNumCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWAddShoopNumCell"];
    IWAddShoopNumCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWAddShoopNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _shoopNum = 1;
        // 购买数量
        UILabel *shoopLabel = [[UILabel alloc] init];
        shoopLabel.text = @"购买数量";
        shoopLabel.textColor = IWColor(50, 50, 50);
        shoopLabel.font = kFont28px;
        [shoopLabel sizeToFit];
        shoopLabel.frame = CGRectMake(kFRate(10), 0, shoopLabel.frame.size.width, kFRate(50));
        [self.contentView addSubview:shoopLabel];
        
        // 按钮
        UIButton *minBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        minBtn.layer.borderWidth = kFRate(2);
        minBtn.layer.borderColor = IWColor(240, 240, 240).CGColor;
        minBtn.layer.cornerRadius = kFRate(3);
        [minBtn setTitle:@"－" forState:UIControlStateNormal];
        [minBtn setTitleColor:IWColor(127, 127, 127) forState:UIControlStateNormal];
        [minBtn addTarget:self action:@selector(minBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *shoopNumLabel = [[UILabel alloc] init];
        shoopNumLabel.textColor = IWColor(50, 50, 50);
        shoopNumLabel.textAlignment = NSTextAlignmentCenter;
        shoopNumLabel.font = kFont28px;
        shoopNumLabel.text = [NSString stringWithFormat:@"%ld",_shoopNum];
        shoopNumLabel.layer.borderWidth = kFRate(2);
        shoopNumLabel.layer.borderColor = IWColor(240, 240, 240).CGColor;
        [self.contentView addSubview:shoopNumLabel];
        self.shoopNumLabel = shoopNumLabel;
        
        [self.contentView addSubview:minBtn];
        self.minusBtn = minBtn;
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.layer.borderWidth = kFRate(2);
        addBtn.layer.borderColor = IWColor(240, 240, 240).CGColor;
        addBtn.layer.cornerRadius = kFRate(3);
        [addBtn setTitle:@"＋" forState:UIControlStateNormal];
        [addBtn setTitleColor:IWColor(127, 127, 127) forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addBtn];
        self.addBtn = addBtn;
        
        CGFloat minBtnX = kViewWidth - (kFRate(25) + kFRate(5) + kFRate(37) + kFRate(5) + kFRate(25) + kFRate(20));
        minBtn.frame = CGRectMake(minBtnX, kFRate(12.5), kFRate(25), kFRate(25));
        shoopNumLabel.frame = CGRectMake(CGRectGetMaxX(minBtn.frame) + kFRate(5), kFRate(12.5), kFRate(37), kFRate(25));
        addBtn.frame = CGRectMake(CGRectGetMaxX(shoopNumLabel.frame) + kFRate(5), kFRate(12.5), kFRate(25), kFRate(25));
    }
    return self;
}

- (void)minBtnClick
{
    if (_shoopNum > 1) {
        _shoopNum --;
        self.shoopNumLabel.text = [NSString stringWithFormat:@"%ld",_shoopNum];
    }
    // 数量回调
    if (self.IWAddShopNum) {
        self.IWAddShopNum(_shoopNum);
    }
}

- (void)addBtnClick
{
    if (_shoopNum < 999) {
        _shoopNum ++;
        self.shoopNumLabel.text = [NSString stringWithFormat:@"%ld",_shoopNum];
    }
    if (self.IWAddShopNum) {
        self.IWAddShopNum(_shoopNum);
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
