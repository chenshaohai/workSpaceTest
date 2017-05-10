//
//  IWToViewCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/13.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWToViewCell.h"

@interface IWToViewCell ()

@end

@implementation IWToViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
{
    NSString *ID = [NSString stringWithFormat:@"IWToViewCell%ld",indexPath.row];
    IWToViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWToViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 上线
        UIView *linSView = [[UIView alloc] init];
        linSView.backgroundColor = kLineColor;
        [self.contentView addSubview:linSView];
        self.linSView = linSView;
        
        // 下线
        UIView *linXView = [[UIView alloc] init];
        linXView.backgroundColor = kLineColor;
        [self.contentView addSubview:linXView];
        self.linXView = linXView;
        
        // 图标
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
        
        // 物流
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = kFont28px;
        contentLabel.textColor = IWColor(79, 79, 79);
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        // 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = kFont24px;
        timeLabel.textColor = IWColor(165, 165, 165);
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
    }
    return self;
}

- (void)setModel:(IWToViewModel *)model
{
    _model = model;
    
    // 赋值
    _contentLabel.text = _model.AcceptStation;
    _timeLabel.text = _model.AcceptTime;
    _imgView.image = _IMG(@"IWNoSelect");
    
    // Frame
    _linSView.frame = _model.linSF;
    _linXView.frame = _model.linXF;
    _imgView.frame = _model.imgF;
    _contentLabel.frame = _model.contentF;
    _timeLabel.frame = _model.timeF;
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
