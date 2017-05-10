//
//  EPObPartProjectViewCell.m
//  E-Platform
//
//  Created by 陈敬 on 2017/3/9.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "EPObPartProjectViewCell.h"

#define IS_IPHONE_5 (IS_IPHONE && SCREEN_WIDTH == 320)

#define CELLHeight 80
#define TOPMargin 12
#define RightImageWidth 20
#define RightMargin 10

#define imageHorizontalMargin ((([UIScreen mainScreen].bounds.size.width)==320)?12.5:16)
#define imageWidth 60

#define stateLabelHorizontalMargin ((([UIScreen mainScreen].bounds.size.width)==320)?12.5:16)


#define detailLabelHeight 30
#define detailLabelFont 11

#define numberLabelWidth 65

#define LabelFont 11

#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_WIDTH == 320)


@interface EPObPartProjectViewCell ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *adminLabel;
@property (nonatomic, strong) UILabel *scheduleLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *topLabel;
//右边的箭头
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UILabel *departmentLabel;



@end

@implementation EPObPartProjectViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.headImageView];
    [self addSubview:self.rightImage];
    [self addSubview:self.topLabel];
    
    [self addSubview:self.numberLabel];
    [self addSubview:self.scheduleLabel];
    [self addSubview:self.adminLabel];
    
    [self addSubview:self.lineView];
}


- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0,CELLHeight - 0.5,SCREEN_WIDTH, 0.5)];
        _lineView.backgroundColor = COLOR_HEX(0xdedede);
    }
    return _lineView;
}


- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, TOPMargin + 7, CELLHeight / 2, CELLHeight / 2)];
        
    }
    return _headImageView;
}

- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        CGRect frame = _topLabel.frame;
        frame.origin.x = self.headImageView.right + 15;
        frame.origin.y = TOPMargin;
        frame.size.width = kViewWidth - self.headImageView.right - 15;
        frame.size.height = CELLHeight / 4;
        _topLabel.frame = frame;
        _topLabel.textColor = COLOR_HEX(0x333333);
        _topLabel.textAlignment = NSTextAlignmentLeft;
        _topLabel.font = [UIFont systemFontOfSize:16];
    }
    return _topLabel;
}



//编号label
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        CGRect frame = CGRectZero;
        frame.origin.x = _headImageView.right + imageHorizontalMargin;
        frame.origin.y = _topLabel.bottom + 3;
        frame.size.width = 150;
        frame.size.height = detailLabelHeight/2;
        _numberLabel.frame = frame;
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = MyFont(LabelFont);
        _numberLabel.textColor = COLOR_HEX(0x999999);
    }
    return _numberLabel;
}

//负责人label
- (UILabel *)scheduleLabel{
    if (!_scheduleLabel) {
        _scheduleLabel = [[UILabel alloc] init];
        CGRect frame = CGRectZero;
        frame.origin.x = _numberLabel.right + 5;
//        SCREEN_WIDTH - 75 - 100;
        
        frame.origin.y = _topLabel.bottom + 3;
        frame.size.width = 75;
        frame.size.height = detailLabelHeight/2;
        _scheduleLabel.frame = frame;
        _scheduleLabel.font = MyFont(LabelFont);
        _scheduleLabel.textColor = COLOR_HEX(0x999999);
    }
    return _scheduleLabel;
}

//部门label
- (UILabel *)adminLabel{
    if (!_adminLabel) {
        _adminLabel = [[UILabel alloc] init];
        CGRect frame = CGRectZero;
        frame.origin.x = _numberLabel.left;
        frame.origin.y = _numberLabel.bottom + 3;
        frame.size.width = 200;
        frame.size.height = detailLabelHeight/2;
        _adminLabel.frame = frame;
        _adminLabel.textAlignment = NSTextAlignmentLeft;
        _adminLabel.font = MyFont(LabelFont);
        _adminLabel.textColor = COLOR_HEX(0x999999);
        
    }
    return _adminLabel;
}
// 图片
- (UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] init];
        CGRect frame = _rightImage.frame;
        frame.origin.x = SCREEN_WIDTH - RightImageWidth - RightMargin;
        frame.origin.y = (80 - 32)/2;
        frame.size.width = RightImageWidth;
        frame.size.height = 32;
        _rightImage.frame = frame;
//        _rightImage.centerY = CELLHeight/2;
        _rightImage.image = [UIImage imageNamed:@"project_image_right"];
        _rightImage.contentMode = UIViewContentModeCenter;
        
    }
    return _rightImage;
}


- (void)setModel:(EPObPartProjectViewModel *)model{
    
    if (model) {
        _model = model;
        _topLabel.text = model.topLabelText;
        _numberLabel.text = model.numberText;
        _adminLabel.text = model.adminText;
        _scheduleLabel.text = model.scheduleText;
        _headImageView.image = [UIImage imageNamed:model.headImageName];
        
         _lineView.frame = CGRectMake(0,CELLHeight - 0.5,SCREEN_WIDTH, 0.5);
    }
}

/**
 *  隐藏下画线
 */
-(void)setHiddenDownLine:(BOOL)hiddenDownLine{
    _hiddenDownLine = hiddenDownLine;
    self.lineView.hidden = hiddenDownLine;
}
@end
