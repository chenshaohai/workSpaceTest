//
//  IWDetailsOneCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/25.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailsOneCell.h"

@interface IWDetailsOneCell ()
// 选择
@property (nonatomic,weak)UILabel *chooseLabel;
// 规格按钮数组
@property (nonatomic,strong)NSMutableArray *standardArr;
// 规格Label
@property (nonatomic,weak)UILabel *standardLabel;
// 减
@property (nonatomic,weak)UIButton *minusBtn;
// 加
@property (nonatomic,weak)UIButton *addBtn;
// 购买数量
@property (nonatomic,weak)UILabel *shoopLabel;
// 数量
@property (nonatomic,weak)UILabel *shoopNumLabel;
// 规格背景
@property (nonatomic,weak)UIView *standardView;
// 线条2
@property (nonatomic,weak)UIView *twoLin;
// 替换键盘
//@property (nonatomic,weak)UIButton *tempBtn;
// 购买数量
@property (nonatomic,assign)NSInteger shoopNum;
// 背景
@property (nonatomic,weak)UIView *cellBack;
// 用于判断进来次数
@property (nonatomic,assign)NSInteger inToNum;
@end

@implementation IWDetailsOneCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDetailsOneCell"];
    IWDetailsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDetailsOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _inToNum = 0;
        self.standardArr = [[NSMutableArray alloc] init];
        // cell背景
        UIView *cellBack = [[UIView alloc] init];
        cellBack.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cellBack];
        self.cellBack = cellBack;
        
        _shoopNum = 0;
        UILabel *chooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(13), 0, kViewWidth - kFRate(26), kFRate(39.5))];
        chooseLabel.text = @"选择";
        chooseLabel.textColor = IWColor(127, 127, 127);
        chooseLabel.font = kFont28px;
        [cellBack addSubview:chooseLabel];
        self.chooseLabel = chooseLabel;
        
        UIView *oneLin = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(chooseLabel.frame), kViewWidth, kFRate(0.5))];
        oneLin.backgroundColor = IWColor(237, 239, 240);
        [cellBack addSubview:oneLin];
        
        // 规格
        UIView *standardView = [[UIView alloc] init];
        standardView.backgroundColor = [UIColor whiteColor];
        [cellBack addSubview:standardView];
        self.standardView = standardView;
        
        UILabel *standardLabel = [[UILabel alloc] init];
        standardLabel.text = @"规格";
        standardLabel.textColor = IWColor(127, 127, 127);
        standardLabel.font = kFont28px;
        [standardView addSubview:standardLabel];
        self.standardLabel = standardLabel;
        
        UIView *twoLin = [[UIView alloc] init];
        twoLin.backgroundColor = IWColor(240, 240, 240);
        [cellBack addSubview:twoLin];
        self.twoLin = twoLin;
        
        // 购买数量
        UILabel *shoopLabel = [[UILabel alloc] init];
        shoopLabel.text = @"购买数量";
        shoopLabel.font = kFont28px;
        shoopLabel.textColor = IWColor(127, 127, 127);
        [cellBack addSubview:shoopLabel];
        self.shoopLabel = shoopLabel;
        
        UIButton *minBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        minBtn.layer.borderWidth = kFRate(2);
        minBtn.layer.borderColor = IWColor(240, 240, 240).CGColor;
        minBtn.layer.cornerRadius = kFRate(3);
        [minBtn setTitle:@"－" forState:UIControlStateNormal];
        [minBtn setTitleColor:IWColor(127, 127, 127) forState:UIControlStateNormal];
        [minBtn addTarget:self action:@selector(minBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *shoopNumLabel = [[UILabel alloc] init];
        shoopNumLabel.textColor = IWColor(120, 120, 120);
        shoopNumLabel.textAlignment = NSTextAlignmentCenter;
        shoopNumLabel.font = kFont28px;
        shoopNumLabel.text = [NSString stringWithFormat:@"%ld",_shoopNum];
        shoopNumLabel.layer.borderWidth = kFRate(2);
        shoopNumLabel.layer.borderColor = IWColor(240, 240, 240).CGColor;
        [cellBack addSubview:shoopNumLabel];
        self.shoopNumLabel = shoopNumLabel;
        
        [cellBack addSubview:minBtn];
        self.minusBtn = minBtn;
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.layer.borderWidth = kFRate(2);
        addBtn.layer.borderColor = IWColor(240, 240, 240).CGColor;
        addBtn.layer.cornerRadius = kFRate(3);
        [addBtn setTitle:@"＋" forState:UIControlStateNormal];
        [addBtn setTitleColor:IWColor(127, 127, 127) forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cellBack addSubview:addBtn];
        self.addBtn = addBtn;
    }
    return self;
}

-(void)setDetailsModel:(IWDetailsModel *)detailsModel
{
    _detailsModel = detailsModel;
    _standardView.frame = _detailsModel.standardViewF;
    _standardLabel.frame = _detailsModel.standardLabelF;
    _twoLin.frame = CGRectMake(0, CGRectGetMaxY(_standardView.frame), kViewWidth, kFRate(0.5));
    if (_inToNum == 0) {
        for (NSInteger i = 0; i < _detailsModel.standardArr.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = [_detailsModel.btnFArr[i] CGRectValue];
            [btn setTitle:_detailsModel.standardArr[i] forState:UIControlStateNormal];
            btn.tag = i + 55555;
            btn.titleLabel.font = kFont28px;
            if (i == 0) {
                [btn setTitleColor:[UIColor HexColorToRedGreenBlue:@"#ff3461"] forState:UIControlStateNormal];
                btn.layer.borderColor = [UIColor HexColorToRedGreenBlue:@"#ff3461"].CGColor;
            }else{
                [btn setTitleColor:IWColor(137, 127, 127) forState:UIControlStateNormal];
                btn.layer.borderColor = IWColor(180, 180, 180).CGColor;
            }
            btn.layer.borderWidth = kFRate(1);
            btn.layer.cornerRadius = kFRate(5);
            [btn addTarget:self action:@selector(standarBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_standardView addSubview:btn];
            [self.standardArr addObject:btn];
        }
    }
    self.shoopLabel.frame = CGRectMake(kFRate(13), CGRectGetMaxY(_twoLin.frame), _detailsModel.shoopNumW, kFRate(60));
    self.minusBtn.frame = CGRectMake(kFRate(13) + CGRectGetMaxX(self.shoopLabel.frame), CGRectGetMaxY(_twoLin.frame) + kFRate(17.5), kFRate(25), kFRate(25));
    self.shoopNumLabel.frame = CGRectMake(CGRectGetMaxX(self.minusBtn.frame) - kFRate(2) , CGRectGetMaxY(_twoLin.frame) + kFRate(17.5), kFRate(37), kFRate(25));
    self.addBtn.frame = CGRectMake(CGRectGetMaxX(self.shoopNumLabel.frame) - kFRate(2), CGRectGetMaxY(_twoLin.frame) + kFRate(17.5), kFRate(25), kFRate(25));
    self.cellBack.frame = CGRectMake(0, kFRate(5), kViewWidth, _detailsModel.cellOneH);
    _inToNum ++;
}

// 规格选中状态
- (void)standarBtn:(UIButton *)sender
{;
    for (UIButton *tempBtn in self.standardArr) {
        if (tempBtn.tag == sender.tag) {
            tempBtn.layer.borderColor = [UIColor HexColorToRedGreenBlue:@"#ff3461"].CGColor;
            [tempBtn setTitleColor:[UIColor HexColorToRedGreenBlue:@"#ff3461"] forState:UIControlStateNormal];
        }else{
            tempBtn.layer.borderColor = IWColor(180, 180, 180).CGColor;
            [tempBtn setTitleColor:IWColor(137, 127, 127) forState:UIControlStateNormal];
        }
    }
}

- (void)minBtnClick
{
    if (_shoopNum > 0) {
        _shoopNum --;
        self.shoopNumLabel.text = [NSString stringWithFormat:@"%ld",_shoopNum];
    }
}

- (void)addBtnClick
{
    if (_shoopNum < 999) {
        _shoopNum ++;
        self.shoopNumLabel.text = [NSString stringWithFormat:@"%ld",_shoopNum];
    }
}

@end
