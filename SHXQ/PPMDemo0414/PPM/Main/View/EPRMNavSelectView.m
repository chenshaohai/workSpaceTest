//
//  EPRMNavSelectView.m
//  E-Platform
//
//  Created by Apple on 2017/2/14.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "EPRMNavSelectView.h"
@class EPRMNavSelectViewCell;

static const CGFloat itemHeight = 40.f;

@interface EPRMNavSelectView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIImageView *titleArraw;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation EPRMNavSelectView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectIndex:(NSInteger)selectIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.selectIndex = selectIndex;
        self.hidden = YES;
        [self addSubview:self.bgView];
        [self addSubview:self.tableview];
        [self creatNavViews];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        [self addSubview:self.bgView];
        [self addSubview:self.tableview];
        [self creatNavViews];
        
    }
    return self;
}

- (void)reloadDataWithTitles:(NSArray *)titles selectIndex:(NSInteger)selectIndex
{
    self.titles = titles;
    self.selectIndex = selectIndex;
    self.tableview.frame = CGRectMake(0, -(self.titles.count *itemHeight), self.width, self.titles.count *itemHeight);
    [self.tableview reloadData];
    [self.titleBtn setTitle:self.titles[self.selectIndex] forState:UIControlStateNormal];
    CGRect rect = [self.titleBtn.titleLabel.text boundingRectWithSize:CGSizeMake(1000, self.titleBtn.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleBtn.titleLabel.font} context:nil];
    self.titleBtn.width = rect.size.width + 12.f;
    self.titleArraw.left = self.titleBtn.width - 5.f;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -(self.titles.count *itemHeight), self.width, self.titles.count *itemHeight) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EPRMNavSelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPRMNavSelectViewCell"];
    if (!cell) {
        cell = [[EPRMNavSelectViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EPRMNavSelectViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.titles.count > indexPath.row) {
        [cell fillDataWithTitle:self.titles[indexPath.row] isSelect:(indexPath.row == self.selectIndex)];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return itemHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectIndex == indexPath.row) {
        [self dismiss];
        return;
    }
    self.selectIndex = indexPath.row;
    [self.titleBtn setTitle:self.titles[self.selectIndex] forState:UIControlStateNormal];
    CGRect rect = [self.titleBtn.titleLabel.text boundingRectWithSize:CGSizeMake(1000, self.titleBtn.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleBtn.titleLabel.font} context:nil];
    self.titleBtn.width = rect.size.width + 12.f;
    self.titleArraw.left = self.titleBtn.width - 5.f;
    [self dismiss];
    [self.tableview reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickNavItemWithIndex:)]) {
        [self.delegate clickNavItemWithIndex:self.selectIndex];
    }
}

- (void)creatNavViews
{
    self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.titleBtn.frame = CGRectMake(0, 0, 100, 30);
    
    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleBtn setTitle:self.titles[self.selectIndex] forState:UIControlStateNormal];
    CGRect rect = [self.titleBtn.titleLabel.text boundingRectWithSize:CGSizeMake(1000, self.titleBtn.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleBtn.titleLabel.font} context:nil];
    self.titleBtn.width = rect.size.width + 12.f;
    
    self.titleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleArraw = [[UIImageView alloc]initWithFrame:CGRectMake(self.titleBtn.width - 5.f, 11.f, 32/3.f, 6.f)];
    self.titleArraw.image = [UIImage imageNamed:@"research_navArrow"];
    [self.titleBtn addSubview:self.titleArraw];
}

- (void)clickTitleBtn:(UIButton *)sender
{
    if (self.hidden) {
        [self show];
    }else{
        [self dismiss];
    }
}

- (void)show
{
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.alpha = 0.5;
        self.tableview.top = 0;
        CGAffineTransform transform = CGAffineTransformMakeRotation(180 * M_PI/180.0);
        [self.titleArraw setTransform:transform];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.alpha = 0;
        self.tableview.top = -(self.titles.count *40.f);
        CGAffineTransform transform = CGAffineTransformMakeRotation(-360 * M_PI/180.0);
        [self.titleArraw setTransform:transform];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@interface EPRMNavSelectViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation EPRMNavSelectViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height + 0.5f)];
        _titleLabel.backgroundColor = COLOR_HEX(0x29324c);
        _titleLabel.textColor = COLOR_HEX(0xffffff);
        _titleLabel.font =  [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _titleLabel;
}

- (void)fillDataWithTitle:(NSString *)title isSelect:(BOOL)isSelect
{
    self.titleLabel.text = title;
    if (isSelect) {
        self.titleLabel.textColor = COLOR_HEX(0x2ec7c9);
    }else
    {
        self.titleLabel.textColor = COLOR_HEX(0xffffff);
    }
}
@end

