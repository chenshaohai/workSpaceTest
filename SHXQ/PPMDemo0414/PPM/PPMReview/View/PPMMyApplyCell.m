//
//  PPMMyApplyCell.m
//  PPM
//
//  Created by lu_ios on 17/4/13.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import "PPMMyApplyCell.h"
@interface PPMMyApplyCell ()
/**
 *  背景 图片
 */
@property (nonatomic, weak)UIImageView *bgView;
/**
 *  图标
 */
@property (nonatomic, weak)UIImageView *iconView;
/**
 *  名称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  分类
 */
@property (nonatomic, weak)UILabel *classLabel;
/**
 *  状态
 */
@property (nonatomic, weak)UILabel *stateLabel;
/**
 *  线
 */
@property (nonatomic, strong) UIView *lineView;


@end

@implementation PPMMyApplyCell

// 随机色
//#define kArc4randomColor  COLOR_HEX(0x2ec8c9);  [UIColor colorWithHexRGBString:[NSString stringWithFormat:@"#%d0%d0%d0",arc4random_uniform(9),arc4random_uniform(9),arc4random_uniform(9)]]
//#define kArc4randomColor [UIColor clearColor]

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *PPMMyApplyCellIdentifier = @"PPMMyApplyCellIdentifier";
    PPMMyApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:PPMMyApplyCellIdentifier];
    if (cell == nil) {
        cell = [[PPMMyApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PPMMyApplyCellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        // 去掉选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  背景
        UIImageView *bgView = [[UIImageView alloc]init];
        bgView.userInteractionEnabled = YES;
        bgView.layer.cornerRadius = 4.0;
        self.bgView = bgView;
        [self.contentView addSubview:bgView];
        // 图标
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(16,13,10,10)];
        iconView.userInteractionEnabled = YES;
        iconView.layer.cornerRadius = 5;
        self.iconView = iconView;
        [bgView addSubview:iconView];
        
        //
        CGFloat stateLabelW = 65;
        CGFloat stateLabelPadding = 10;
        CGFloat stateLabelH = 54;
        UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kViewWidth - stateLabelW - 3 * stateLabelPadding , 0, stateLabelW, stateLabelH)];
        stateLabel.font = kFont24px;
        stateLabel.textColor = COLOR_HEX(0x2ec8c9);
        stateLabel.numberOfLines = 2;
        stateLabel.textAlignment = NSTextAlignmentCenter;
//        stateLabel.backgroundColor = kArc4randomColor;
        [self.bgView addSubview:stateLabel];
        self.stateLabel  = stateLabel;
        
        
        // 名称
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconView.frame) + 8, 7, CGRectGetMinX(stateLabel.frame) -  CGRectGetMaxX(self.iconView.frame) - 2 * stateLabelPadding, 22)];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = COLOR_HEX(0x666666);
//        nameLabel.backgroundColor = kArc4randomColor;
        [self.bgView addSubview:nameLabel];
        self.nameLabel  = nameLabel;
        nameLabel.text = @"电脑设备故障，开发无法正常工作。";
        
        
        
        //
        UILabel *classLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame),CGRectGetMaxY(nameLabel.frame) + 3, CGRectGetMinX(stateLabel.frame) -  CGRectGetMaxX(self.iconView.frame) - 2 * stateLabelPadding, 20)];
        classLabel.font = [UIFont systemFontOfSize:12];
        classLabel.textColor =  COLOR_HEX(0x999999);
//        classLabel.backgroundColor = kArc4randomColor;
        [self.bgView addSubview:classLabel];
        self.classLabel  = classLabel;
        classLabel.text =  @"分类：显示异常";
        
        
        
      [self addSubview:self.lineView];
    }
    return self;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(20,54,SCREEN_WIDTH - 40, 0.5)];
        _lineView.backgroundColor = COLOR_HEX(0xdedede);
    }
    return _lineView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModelDic:(NSDictionary *)modelDic{
    
    _modelDic = modelDic;
    
    self.iconView.backgroundColor = modelDic[@"iconColor"];
    
    self.stateLabel.text  = modelDic[@"state"];
    self.classLabel.text  = [NSString stringWithFormat:@"分类：%@", modelDic[@"class"]];
    self.nameLabel.text  = modelDic[@"name"];
}

/**
 *  隐藏下画线
 */
-(void)setHiddenDownLine:(BOOL)hiddenDownLine{
    _hiddenDownLine = hiddenDownLine;
    self.lineView.hidden = hiddenDownLine;
}
@end

