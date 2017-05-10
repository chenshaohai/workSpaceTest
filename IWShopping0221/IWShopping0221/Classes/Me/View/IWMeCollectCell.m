//
//  IWMeCollectCell.m
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeCollectCell.h"

@interface IWMeCollectCell ()
// 图片
@property (nonatomic,weak)UIImageView *imgView;
// 名字
@property (nonatomic,weak)UILabel *nameLable;
// 价格
@property (nonatomic,weak)UILabel *nowPriceLabel;
// 市场价格
@property (nonatomic,weak)UILabel *allPriceLabel;
// 库存
@property (nonatomic,weak)UILabel *stockLabel;
@property(nonatomic ,strong)UIButton *crashBtn;

@property (nonatomic,weak)UIView *line;
@end

@implementation IWMeCollectCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWMeCollectCell"];
    IWMeCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWMeCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(10), kFRate(100), kFRate(100))];
        [self.contentView addSubview:img];
        self.imgView = img;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(120), kFRate(10), kViewWidth - kFRate(130), kFRate(55))];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = kFont24px;
        nameLabel.numberOfLines = 3;
        [self.contentView addSubview:nameLabel];
        self.nameLable = nameLabel;
        
        UILabel * nowPriceLabel= [[UILabel alloc] initWithFrame:CGRectMake(kFRate(120), CGRectGetMaxY(nameLabel.frame) + kFRate(5), kViewWidth - kFRate(130), kFRate(15))];
        nowPriceLabel.textColor = [UIColor redColor];
        nowPriceLabel.font = kFont24px;
        [self.contentView addSubview:nowPriceLabel];
        self.nowPriceLabel = nowPriceLabel;
        
        UILabel * allPriceLabel= [[UILabel alloc] initWithFrame:CGRectMake(kFRate(120),  CGRectGetMaxY(nowPriceLabel.frame) + kFRate(5), kFRate(90), kFRate(15))];
        allPriceLabel.textColor = [UIColor grayColor];
        allPriceLabel.font = kFont22px;
        [self.contentView addSubview:allPriceLabel];
        self.allPriceLabel = allPriceLabel;
        
        UILabel * stockLabel= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(allPriceLabel.frame) + kFRate(5), CGRectGetMaxY(nowPriceLabel.frame) + kFRate(5), kViewWidth - CGRectGetMaxX(allPriceLabel.frame) - kFRate(15), kFRate(15))];
        stockLabel.textColor = [UIColor grayColor];
        stockLabel.font = kFont22px;
        [self.contentView addSubview:stockLabel];
        self.stockLabel = stockLabel;
        
        //删除
        UIImage *crashImage = [UIImage imageNamed:@"IWShoppingtrash"];
        UIButton *crashBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewWidth - kFRate(10) - kFRate(20), CGRectGetMinY(nowPriceLabel.frame) + kFRate(5), kFRate(20), kFRate(20))];
        [crashBtn setImage:crashImage  forState:UIControlStateNormal];
        [crashBtn addTarget:self action:@selector(crashBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:crashBtn];
        self.crashBtn = crashBtn;
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(119.5), kViewWidth, 0.5)];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
        [self addSubview:line];
        self.line = line;

        
    }
    return self;
}

-(void)crashBtnClick:(UIButton *)button{
    
    if (self.crashBtnClick) {
        self.crashBtnClick(self.model);
    }
}

- (void)setModel:(IWMeCollectModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:kImageTotalUrl(model.img)];
     [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:model.img]];
    
    self.nameLable.text = _model.name;
    self.nowPriceLabel.text = [NSString stringWithFormat:@"￥:%@", _model.price];
    self.allPriceLabel.text =  [NSString stringWithFormat:@"市场价:%@", _model.allPrice];
    self.stockLabel.text = [NSString stringWithFormat:@"库存:%@", _model.stock];
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
