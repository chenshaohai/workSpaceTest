//
//  IWBillCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWBillCell.h"

#define kLabelW kViewWidth / 3
#define kFontColor IWColor(103, 103, 103)
#define kLinColor IWColor(240, 240, 240)
@interface IWBillCell ()
@property (nonatomic,weak)UILabel *timeLabel;
@property (nonatomic,weak)UILabel *typeLabel;
@property (nonatomic,weak)UILabel *payLabel;
// btn文字 图片
//@property (nonatomic,weak)UILabel *btnLabel;
//@property (nonatomic,weak)UIImageView *btnImg;
@end

@implementation IWBillCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWBillCell"];
    IWBillCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWBillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 时间
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLabelW, kFRate(40))];
        timeLabel.font = kFont24px;
        timeLabel.textColor = kFontColor;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.layer.borderWidth = kFRate(0.5);
        timeLabel.layer.borderColor = kLinColor.CGColor;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 类型
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelW, 0, kLabelW, kFRate(40))];
        typeLabel.font = kFont24px;
        typeLabel.textColor = kFontColor;
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.layer.borderWidth = kFRate(0.5);
        typeLabel.layer.borderColor = kLinColor.CGColor;
        [self.contentView addSubview:typeLabel];
        self.typeLabel = typeLabel;
        
        // 收支
        UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelW * 2, 0, kLabelW, kFRate(40))];
        payLabel.font = kFont24px;
        payLabel.textColor = IWColor(252, 56, 100);
        payLabel.textAlignment = NSTextAlignmentCenter;
        payLabel.layer.borderWidth = kFRate(0.5);
        payLabel.layer.borderColor = kLinColor.CGColor;
        [self.contentView addSubview:payLabel];
        self.payLabel = payLabel;
        
//        UIControl *contentBtn = [[UIControl alloc] initWithFrame:CGRectMake(kLabelW * 3, 0, kLabelW, kFRate(40))];
//        contentBtn.layer.borderWidth = kFRate(0.5);
//        contentBtn.layer.borderColor = kLinColor.CGColor;
//        [self.contentView addSubview:contentBtn];
//        self.contentBtn = contentBtn;
//        
//        UILabel *btnLabel = [[UILabel alloc] init];
//        btnLabel.textColor = kFontColor;
//        btnLabel.font = kFont24px;
//        [contentBtn addSubview:btnLabel];
//        self.btnLabel = btnLabel;
//        
//        // 18 * 35
//        UIImageView *btnImg = [[UIImageView alloc] init];
//        btnImg.image = _IMG(@"IWNearShoppingDetailNext");
//        [contentBtn addSubview:btnImg];
//        self.btnImg = btnImg;
    }
    return self;
}

- (void)setModel:(IWBillModel *)model
{
    _model = model;
    _timeLabel.text = [NSDate dateToyyyyMMddStringWithInteger:[_model.time doubleValue]];
    _typeLabel.text = _model.content;
    _payLabel.text = _model.payNum;
//    _btnLabel.text = _model.details;
    
//    CGSize maximumLabelSize = CGSizeMake(MAXFLOAT, kFRate(40));//labelsize的最大值
//    NSDictionary *attribute = @{NSFontAttributeName: kFont24px};
//    CGSize expectSize = [_model.details boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
//    CGFloat btnLabelX = (kLabelW - expectSize.width - kFRate(9) - kFRate(5)) / 2;
//    _btnLabel.frame = CGRectMake(btnLabelX, 0, expectSize.width, kFRate(40));
//    _btnImg.frame = CGRectMake(CGRectGetMaxX(_btnLabel.frame) + kFRate(5), (kFRate(40) - kFRate(35) / 3) / 2, kFRate(6), kFRate(35) / 3);
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
