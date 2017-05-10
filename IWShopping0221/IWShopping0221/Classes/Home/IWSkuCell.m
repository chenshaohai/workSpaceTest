//
//  IWSkuCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWSkuCell.h"

@interface IWSkuCell ()
// 规格名字
@property (nonatomic,weak)UILabel *skuName;
// 规格按钮
@property (nonatomic,strong)NSMutableArray *skuBtnArr;
// cell背景
@property (nonatomic,weak)UIView *cellBack;
// 最后个btn
@property (nonatomic,weak)UIButton *lastBtn;
// 用于判断进来次数
@property (nonatomic,assign)NSInteger inToNum;
// 分割线
@property (nonatomic,weak)UIView *linView;
// tempBtn
@property (nonatomic,weak)UIButton *tempBtn;
@end

@implementation IWSkuCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWSkuCell"];
    IWSkuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWSkuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        _skuBtnArr = [[NSMutableArray alloc] init];
        UIView *cellBack = [[UIView alloc] init];
        cellBack.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cellBack];
        self.cellBack = cellBack;
        
        UILabel *skuName = [[UILabel alloc] init];
        skuName.font = kFont28px;
        skuName.textColor = IWColor(50, 50, 50);
        [cellBack addSubview:skuName];
        self.skuName = skuName;
        
        UIView *linView = [[UIView alloc] init];
        linView.backgroundColor = kLineColor;
        [cellBack addSubview:linView];
        self.linView = linView;
    }
    return self;
}

- (void)setSkuModel:(IWDetailSkuModel *)skuModel
{
    _skuModel = skuModel;
    _skuName.text = _skuModel.attributeName;
    
    _skuName.frame = _skuModel.nameF;
    if (_inToNum == 0) {
        for (NSInteger i = 0; i < _skuModel.skuInfosModelArr.count; i ++) {
            IWDetailSkuInfosModel *model = _skuModel.skuInfosModelArr[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = [_skuModel.btnFArr[i] CGRectValue];
            btn.titleLabel.font = kFont24px;
            [btn setBackgroundImage:_IMG(@"IWSkuNomal") forState:UIControlStateNormal];
            [btn setBackgroundImage:_IMG(@"IWSkuSelect") forState:UIControlStateSelected];
            [btn setTitle:model.attributeValueName forState:UIControlStateNormal];
            [btn setTitleColor:IWColor(50, 50, 50) forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.tag = 80000 + i;
            btn.layer.cornerRadius = kFRate(5.0f);
            btn.layer.masksToBounds = YES;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_cellBack addSubview:btn];
            [_skuBtnArr addObject:btn];
            _lastBtn = btn;
        }
        _tempBtn = [self viewWithTag:80000];
        _tempBtn.selected = YES;
    }
    
    _cellBack.frame = CGRectMake(0, 0, kViewWidth, _skuModel.cellH);
    _linView.frame = CGRectMake(kFRate(10), _skuModel.cellH - kFRate(0.5), kViewWidth - kFRate(20), kFRate(0.5));
    _inToNum ++;
}

#pragma mark - 标记按钮
- (void)btnClick:(UIButton *)sender
{
    _tempBtn.selected = NO;
    _tempBtn = sender;
    sender.selected = YES;
    if (self.IWChooseSku) {
        self.IWChooseSku(sender.tag - 80000);
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
