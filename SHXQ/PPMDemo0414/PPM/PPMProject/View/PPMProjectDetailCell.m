//
//  PPMProjectDetailCell.m
//  PPM
//
//  Created by lu_ios on 17/4/14.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import "PPMProjectDetailCell.h"
#import "PPMProgressView.h"
#import "PPMProgressModel.h"
@interface PPMProjectDetailCell()<UIScrollViewDelegate>
/**
 *  左边不动的
 */
@property (nonatomic, strong)UIView *leftView;
/**
 *  右边动的
 */
@property (nonatomic, strong)UIScrollView *rightView;

/**
 *  计划
 */
@property (nonatomic, strong)UIView *planView;
/**
 *  执行
 */
@property (nonatomic, strong)UIView *executeView;

/**
 *  红线
 */
@property (nonatomic, strong)UIImageView *redLine;

/**
 *  大部门
 */
@property (nonatomic, strong)UILabel *departLabel;
/**
 *  编号
 */
@property (nonatomic, strong)UILabel *numberLabel;
/**
 *  部门
 */
@property (nonatomic, strong)UILabel *departSecondLabel;
/**
 *  责任人
 */
@property (nonatomic, strong)UILabel *manNameLabel;
/**
 *  线
 */
@property (nonatomic, strong) UIView *lineView;

/**
 *  底部文字
 */
@property (nonatomic, strong)UILabel *detailTextDownLabel;

/**
 *  圆点
 */
@property (nonatomic, strong)UIView *pointView;
@end
@implementation PPMProjectDetailCell

#define kCellHigh  133.0
#define kCellFirstX   15.0
#define kCellRightPadding   10.0
#define kCellLeftWidth   165.0

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *PPMProjectDetailCellIdentifier = @"PPMProjectDetailCell";
    PPMProjectDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:PPMProjectDetailCellIdentifier];
    if (cell == nil) {
        cell = [[PPMProjectDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PPMProjectDetailCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        // 去掉选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
        [self.rightView addSubview:self.planView];
        [self.rightView addSubview:self.executeView];
        [self.rightView addSubview:self.redLine];
        
        [self addSubview:self.lineView];
        
        [self addSubview:self.detailTextDownLabel];
    }
    return self;
}
#pragma mark 底部文字
-(UILabel *)detailTextDownLabel{
    if (!_detailTextDownLabel) {
        _detailTextDownLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCellFirstX,kCellHigh,SCREEN_WIDTH -  kCellFirstX - kCellRightPadding, 0.5)];
        _detailTextDownLabel.font = MyFont(12);
        _detailTextDownLabel.textColor = COLOR_HEX(0x666666);
        _detailTextDownLabel.numberOfLines = -1;
    }
    return _detailTextDownLabel;
}

#pragma mark 底部线
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(20,kCellHigh - 0.5,SCREEN_WIDTH - 40, 0.5)];
        _lineView.backgroundColor = COLOR_HEX(0xdedede);
    }
    return _lineView;
}
#pragma mark 左边整体
-(UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kCellLeftWidth, kCellHigh)];
        
        
        _pointView = [[UIView alloc]initWithFrame:CGRectMake(kCellFirstX,17,10,10)];
        _pointView.userInteractionEnabled = YES;
        _pointView.layer.cornerRadius = 5;
        [_leftView addSubview:_pointView];
        
        UILabel *departLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_pointView.frame) + 5, 0, kCellLeftWidth -  kCellFirstX - CGRectGetMaxX(_pointView.frame) - 5, 46)];
        [_leftView addSubview:departLabel];
        departLabel.font = MyFont(12);
        departLabel.numberOfLines = 2;
        departLabel.textAlignment = NSTextAlignmentCenter;
        departLabel.textColor = COLOR_HEX(0x000000);
        self.departLabel = departLabel;
        
        
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCellFirstX, CGRectGetMaxY(departLabel.frame),kCellLeftWidth - kCellFirstX - kCellRightPadding, 20)];
        [_leftView addSubview:numberLabel];
        numberLabel.font = MyFont(11);
        numberLabel.textColor = COLOR_HEX(0x999999);
        self.numberLabel = numberLabel;
        
        UILabel *departSecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCellFirstX, CGRectGetMaxY(numberLabel.frame) + 5, CGRectGetWidth(numberLabel.frame), 20)];
        [_leftView addSubview:departSecondLabel];
        departSecondLabel.font = MyFont(11);
        departSecondLabel.textColor = COLOR_HEX(0x999999);
        self.departSecondLabel = departSecondLabel;
        
        UILabel *manNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCellFirstX, CGRectGetMaxY(departSecondLabel.frame) + 5, CGRectGetWidth(numberLabel.frame), 20)];
        [_leftView addSubview:manNameLabel];
        manNameLabel.font = MyFont(11);
        manNameLabel.textColor = COLOR_HEX(0x999999);
        self.manNameLabel = manNameLabel;
        
        //竖线
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kCellLeftWidth - 0.5, 16, 0.5, 103)];
        line.backgroundColor = COLOR_HEX(0xdedede);
        [_leftView addSubview:line];
    }
    return _leftView;
}
#pragma mark  右边整体
-(UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIScrollView alloc]init];
        _rightView.delegate = self;
        _rightView.showsHorizontalScrollIndicator = NO;
    }
    return _rightView;
}
#pragma mark 计划图
-(UIView *)planView{
    if (!_planView) {
        _planView = [[UIView alloc]init];
    }
    return _planView;
}
#pragma mark 执行图
-(UIView *)executeView{
    if (!_executeView) {
        _executeView = [[UIView alloc]init];
    }
    return _executeView;
}
#pragma mark   红线
-(UIImageView *)redLine{
    if (!_redLine) {
        _redLine = [[UIImageView alloc]init];
        
        _redLine.image = [UIImage resizedImageWithName:@"PPMProjectXuXian"];
    }
    return _redLine;
}

#pragma mark  调整尺寸
-(void)layoutSubviews{
    [super layoutSubviews];
    _rightView.frame = CGRectMake(kCellLeftWidth, 0, SCREEN_WIDTH - kCellLeftWidth, 133);
    _rightView.contentSize = CGSizeMake(_model.planDataWidth,0);
    _lineView.frame = CGRectMake(20,kCellHigh - 0.5,SCREEN_WIDTH - 40, 0.5);
}

#pragma mark  设置各个属性
-(void)setModel:(PPMProjectDetailModel *)model{
    _model = model;
    
    //点的颜色
    switch (model.degreeTpye) {
        case PPMProjectDetailDegreeLow:
            self.pointView.backgroundColor = COLOR_HEX(0x5ede9e);
            break;
        case PPMProjectDetailDegreeNormal:
            self.pointView.backgroundColor = COLOR_HEX(0xf8d022);
            break;
        default:
            self.pointView.backgroundColor = COLOR_HEX(0xff6a69);
            break;
    }
    
    self.departLabel.text = model.depart;
    self.numberLabel.text = [NSString stringWithFormat:@"编号:%@", model.number];
    self.departSecondLabel.text = [NSString stringWithFormat:@"部门:%@",model.departSecond];
    self.manNameLabel.text =  [NSString stringWithFormat:@"责任人:%@",model.manName];
    
    //去掉子视图
    for (UIView *subview in self.planView.subviews) {
        [subview removeFromSuperview];
    }
    
    for (UIView *subview in self.executeView.subviews) {
        [subview removeFromSuperview];
    }
    
    
    //计划
    for (PPMProgressModel *progressModel in model.planData) {
        PPMProgressView *progressView = [[PPMProgressView alloc]initWithFrame:progressModel.progressFrame];
        progressView.model = progressModel;
        [self.planView addSubview:progressView];
    }
    //执行
    for (PPMProgressModel *progressModel in model.executeData) {
        PPMProgressView *progressView = [[PPMProgressView alloc]initWithFrame:progressModel.progressFrame];
        progressView.model = progressModel;
        [self.executeView addSubview:progressView];
    }
    
    
    self.redLine.frame = model.redLineFrame;
    
}
#pragma mark 显示底部详情
-(void)setShowDetailText:(BOOL)showDetailText{
    if (showDetailText) {
        self.detailTextDownLabel.frame = CGRectMake(self.detailTextDownLabel.x, self.detailTextDownLabel.y,self.detailTextDownLabel.width, _model.highDetailText);
        self.detailTextDownLabel.hidden = NO;
        self.detailTextDownLabel.text = _model.detailText;
    }else{
        self.detailTextDownLabel.hidden = YES;
        self.detailTextDownLabel.text = @"";
    }
}
#pragma mark  隐藏底部线条
-(void)setHiddenDownLine:(BOOL)hiddenDownLine{
    _hiddenDownLine = hiddenDownLine;
    self.lineView.hidden = hiddenDownLine;
}

@end
