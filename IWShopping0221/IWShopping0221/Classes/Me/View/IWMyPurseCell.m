//
//  IWMyPurseCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/3.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMyPurseCell.h"

@interface IWMyPurseCell ()
// 图片
@property (nonatomic,weak)UIImageView *topImg;
// 名字
@property (nonatomic,weak)UILabel *nameLabel;
// 内容
@property (nonatomic,weak)UILabel *contentLabel;
// 有图标
@property (nonatomic,weak)UIImageView *rightImg;
@end

@implementation IWMyPurseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWMyPurseCell"];
    IWMyPurseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWMyPurseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *topImg = [[UIImageView alloc] init];
        topImg.userInteractionEnabled = YES;
        topImg.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:topImg];
        self.topImg = topImg;
        
        // 名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kFont30px;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = kFont28px;
        contentLabel.textColor = IWColor(120, 120, 120);
        contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        // 有图标
        UIImageView *rightImg = [[UIImageView alloc] init];
        rightImg.userInteractionEnabled = YES;
        rightImg.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:rightImg];
        self.rightImg = rightImg;
        
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(59.5), kViewWidth - kFRate(20), kFRate(0.5))];
        linView.backgroundColor = kLineColor;
        [self.contentView addSubview:linView];
        
    }
    return self;
}

- (void)setModel:(IWMypurseModel *)model
{
    _model = model;
    _topImg.image = _IMG(_model.topImg);
    _nameLabel.text = _model.name;
    _contentLabel.text = _model.content;
    _rightImg.image = _IMG(_model.rightImg);
    
    _topImg.frame = _model.topImgF;
    _nameLabel.frame = _model.nameF;
    _contentLabel.frame = _model.contentF;
    _rightImg.frame = _model.rightImgF;
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
