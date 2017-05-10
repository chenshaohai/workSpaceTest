//
//  IWDetailsFourCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailsFourCell.h"

@interface IWDetailsFourCell ()
// 头像
@property (nonatomic,weak)UIImageView *imgView;
// 时间
@property (nonatomic,weak)UILabel *timeLabel;
// 评论类容
@property (nonatomic,weak)UILabel *contentLabel;
// 名字
@property (nonatomic,weak)UILabel *nameLabel;
// 分割线
@property (nonatomic,weak)UIView *linView;
@end

@implementation IWDetailsFourCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDetailsFourCell"];
    IWDetailsFourCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDetailsFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 头像
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.layer.cornerRadius = kFRate(15.0f);
        imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
        
        // 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = IWColor(181, 181, 181);
        timeLabel.font = kFont24px;
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = IWColor(50, 50, 50);
        contentLabel.font = kFont28px;
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        // 名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = IWColor(181, 181, 181);
        nameLabel.font = kFont24px;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UIView *linView = [[UIView alloc] init];
        linView.backgroundColor = kLineColor;
        [self.contentView addSubview:linView];
        self.linView = linView;
    }
    return self;
}

- (void)setCommentModel:(IWCommentModel *)commentModel
{
    _commentModel = commentModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageUrl,_commentModel.userImg]] placeholderImage:_IMG(@"")];
    _timeLabel.text = _commentModel.createdTime;
    _nameLabel.text = _commentModel.userName;
    _contentLabel.text = _commentModel.evaluateDesc;
    
    // frame
    _imgView.frame = _commentModel.userImgF;
    _nameLabel.frame = _commentModel.userNameF;
    _timeLabel.frame = _commentModel.createdTimeF;
    _contentLabel.frame = _commentModel.evaluateDescF;
    
    _linView.frame = CGRectMake(kFRate(10), _commentModel.cellH - kFRate(0.5), kViewWidth - kFRate(20), kFRate(0.5));
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
