//
//  IWShoppingSureCell.m
//  IWShopping0221
//
//  Created by s on 17/3/15.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWShoppingSureCell.h"

@interface IWShoppingSureCell()
@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UILabel *contentLabel;

@property(nonatomic ,strong)UILabel *priceLabel;

//数量
@property(nonatomic ,strong)UILabel *countLabel;
@property(nonatomic ,strong)UIView *line;
@end

@implementation IWShoppingSureCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWShoppingSureCell = @"IWShoppingSureCell";
    IWShoppingSureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWShoppingSureCell];
    if (cell == nil) {
        cell = [[IWShoppingSureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWShoppingSureCell];
        cell.backgroundColor = [UIColor whiteColor];
        // 去掉选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconView = [[UIImageView alloc]init];
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconView.layer.cornerRadius = 5;
        self.iconView.clipsToBounds = YES;
        self.iconView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.iconView];
        //名字
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.numberOfLines = 2;
        self.nameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"353535"];
        self.nameLabel.font = kFont28px;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nameLabel];
        
        //规格
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.numberOfLines = 1;
        self.contentLabel.textColor = [UIColor HexColorToRedGreenBlue:@"353535"];
        self.contentLabel.font = kFont24px;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.contentLabel];
        
        //价格
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.numberOfLines = 1;
        self.priceLabel.textColor = kColorRGB(251, 22, 78);
        self.priceLabel.font = kFont24px;
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.priceLabel];
        
        
        
        //数量
        UILabel *countLabel = [[UILabel alloc]init];
        countLabel.font = kFont24px;
        countLabel.textColor = kColorRGB(221, 22, 78);
        [self addSubview:countLabel];
        self.countLabel = countLabel;
        countLabel.textAlignment = NSTextAlignmentRight;
        
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

-(void)setModel:(IWShoppingModel *)model{
    _model = model;
    
    CGFloat firstX = 125;
    
    //图标
    self.iconView.frame = CGRectMake( kFRate(25),kFRate(5),kFRate(85),kFRate(85));
    [self.iconView sd_setImageWithURL: [NSURL URLWithString:kImageTotalUrl(model.logo)] placeholderImage:[UIImage imageNamed:model.logo]];
    //名字
    self.nameLabel.frame = CGRectMake(kFRate(firstX),kFRate(10),kViewWidth - kFRate(firstX),  kFRate(34));
    self.nameLabel.text =  model.name;
    //规格
    self.contentLabel.text =  model.content;
    self.contentLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.nameLabel.frame), kViewWidth - kFRate(firstX),  kFRate(30));
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %@ + %@ 贝壳",model.price,model.integral];
    self.priceLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.contentLabel.frame), kFRate(150),  kFRate(13));
    
    
    self.countLabel.text = [NSString stringWithFormat:@"X %@", model.count];
    self.countLabel.frame = CGRectMake(kViewWidth - kFRate(60),CGRectGetMinY(self.priceLabel.frame), kFRate(50),  kFRate(13));
    
    
    self.line.frame = CGRectMake(0,kFRate(94.5), kViewWidth, 0.5);
}

@end
