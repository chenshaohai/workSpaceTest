//
//  IWAddressCell.m
//  IWShopping0221
//
//  Created by admin on 2017/3/8.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWAddressCell.h"
// 背景色和分隔线颜色
#define kLinColor IWColor(240, 240, 240)
#define kFontColor IWColor(57, 57, 57)
#define kMarkColor IWColor(252, 33, 95)
#define kTextFont kFont32px
@interface IWAddressCell ()
// name
@property (nonatomic,weak)UILabel *nameLabel;
// phone
@property (nonatomic,weak)UILabel *phoneLabel;
// address
@property (nonatomic,weak)UILabel *addressLabel;
// 分割线
@property (nonatomic,weak)UIView *linView;
// 编辑
@property (nonatomic,weak)UIButton *editBtn;
// 删除
@property (nonatomic,weak)UIButton *deleteBtn;
// cell白色背景
@property (nonatomic,weak)UIView *cellView;

@end

@implementation IWAddressCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWAddressCell"];
    IWAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        UIView *cellView = [[UIView alloc] init];
        cellView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cellView];
        self.cellView = cellView;
        
        // name
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = kFontColor;
        nameLabel.font = kTextFont;
        [cellView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // phone
        UILabel *phoneLabel = [[UILabel alloc] init];
        phoneLabel.textColor = kFontColor;
        phoneLabel.font = kTextFont;
        [cellView addSubview:phoneLabel];
        self.phoneLabel = phoneLabel;
        
        // address
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.textColor = kFontColor;
        addressLabel.font = kTextFont;
        addressLabel.numberOfLines = 0;
        [cellView addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        // 分割线
        UIView *linView = [[UIView alloc] init];
        linView.backgroundColor = kLineColor;
        [cellView addSubview:linView];
        self.linView = linView;
        
        // 选择按钮
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.titleLabel.font = kTextFont;
        [selectBtn setTitleColor:kFontColor forState:UIControlStateNormal];
        [selectBtn setTitleColor:kMarkColor forState:UIControlStateSelected];
        [selectBtn setImage:_IMG(@"IWNoSelect") forState:UIControlStateNormal];
        [selectBtn setImage:_IMG(@"IWSelect") forState:UIControlStateSelected];
        [selectBtn setTitle:@" 设置默认" forState:UIControlStateNormal];
        [selectBtn setTitle:@" 默认" forState:UIControlStateSelected];
        selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:selectBtn];
        self.selectBtn = selectBtn;
        
        // 编辑
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.titleLabel.font = kTextFont;
        [editBtn setTitle:@" 编辑" forState:UIControlStateNormal];
        [editBtn setTitleColor:kFontColor forState:UIControlStateNormal];
        [editBtn setImage:_IMG(@"IWUpate") forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:editBtn];
        self.editBtn = editBtn;
        
        // 删除
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.titleLabel.font = kTextFont;
        [deleteBtn setTitle:@" 删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:kFontColor forState:UIControlStateNormal];
        [deleteBtn setImage:_IMG(@"IWDelete") forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
    }
    return self;
}

- (void)setModel:(IWAddressModel *)model
{
    _model = model;
    _nameLabel.text = _model.name;
    _phoneLabel.text = _model.phone;
    _addressLabel.text = _model.address;
    
    // frame
    _nameLabel.frame = _model.nameF;
    _phoneLabel.frame = _model.phoneF;
    _addressLabel.frame = _model.addressF;
    _linView.frame = _model.linF;
    // 按钮
    _selectBtn.frame = _model.selectBtnF;
    _selectBtn.selected = _model.state;
    
    _editBtn.frame = _model.editF;
    _deleteBtn.frame = _model.deleteF;
    
    _cellView.frame = CGRectMake(0, kFRate(10), kViewWidth, _model.cellH - kFRate(10));
    
}

#pragma mark - 编辑
- (void)editBtnClick
{
    if (self.IWAddressCellEdit) {
        self.IWAddressCellEdit();
    }
}
#pragma mark - 删除
- (void)deleteBtnClick
{
    if (self.IWAddressCellDelete) {
        self.IWAddressCellDelete();
    }
}
#pragma mark - 选择地址
- (void)selectBtnClick
{
    if (self.IWAddressCellChange) {
        self.IWAddressCellChange();
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
