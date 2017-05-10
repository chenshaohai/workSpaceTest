//
//  IWDetailsTwoCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/25.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailsTwoCell.h"

@interface IWDetailsTwoCell ()
// 购买需知
@property (nonatomic,weak)UILabel *knowLable;
// 运费
@property (nonatomic,weak)UILabel *freightLable;
// 税率
@property (nonatomic,weak)UILabel *taxRateLabel;
// 背景
@property (nonatomic,weak)UIView *cellBack;
@end

@implementation IWDetailsTwoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDetailsTwoCell"];
    IWDetailsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDetailsTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // cell背景
        UIView *cellBack = [[UIView alloc] init];
        cellBack.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cellBack];
        self.cellBack = cellBack;
        
        // 购买需知
        UILabel *knowLabel = [[UILabel alloc] init];
        knowLabel.text = @"购买需知";
        knowLabel.textColor = IWColor(104, 104, 104);
        knowLabel.font = kFont22px;
        [knowLabel sizeToFit];
        knowLabel.frame = CGRectMake(kFRate(13), 0, knowLabel.frame.size.width, kFRate(30));
        [cellBack addSubview:knowLabel];
        self.knowLable = knowLabel;
        
        //运费
        UILabel *freightLabel = [[UILabel alloc] init];
        freightLabel.numberOfLines = 0;
        freightLabel.font = kFont22px;
        freightLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
        [cellBack addSubview:freightLabel];
        self.freightLable = freightLabel;
        
        // 税率
        UILabel *taxRateLabel = [[UILabel alloc] init];
        taxRateLabel.font = kFont22px;
        taxRateLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
        [cellBack addSubview:taxRateLabel];
        self.taxRateLabel = taxRateLabel;
    }
    return self;
}

- (void)setDetailsModel:(IWDetailsModel *)detailsModel
{
    _detailsModel = detailsModel;
    _freightLable.text = _detailsModel.knowStr;
    _taxRateLabel.text = _detailsModel.taxRate;
    _freightLable.frame = _detailsModel.freightF;
    _taxRateLabel.frame = _detailsModel.taxRateF;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"税率：本商品税率11.9%"];
    NSRange redRange = NSMakeRange([[attStr string] rangeOfString:@"税率11.9%"].location, [[attStr string] rangeOfString:@"税率11.9%"].length);
    [attStr addAttribute:NSForegroundColorAttributeName value:IWColor(252, 82, 114) range:redRange];
    [_taxRateLabel setAttributedText:attStr];
    _cellBack.frame = CGRectMake(0, kFRate(5), kViewWidth, _detailsModel.cellTwoH);
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
