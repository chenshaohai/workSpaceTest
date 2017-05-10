//
//  IWMeOrderFormCell.m
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeOrderFormCell.h"

@interface IWMeOrderFormCell()
@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UILabel *countLabel;

@property(nonatomic ,strong)UILabel *priceLabel;
@property(nonatomic ,strong)UIView *line;
@end


// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]

#define  firstX  100
#define  contentW  (kViewWidth - kFRate(firstX) - 15)

@implementation IWMeOrderFormCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWMeOrderFormCell = @"IWMeOrderFormCell";
    IWMeOrderFormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWMeOrderFormCell];
    if (cell == nil) {
        cell = [[IWMeOrderFormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWMeOrderFormCell];
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
        
        
        // Initialization code
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
        
        //个数
                self.countLabel = [[UILabel alloc]init];
                self.countLabel.backgroundColor = [UIColor clearColor];
                self.countLabel.numberOfLines = 1;
                self.countLabel.textColor = [UIColor HexColorToRedGreenBlue:@"353535"];
                self.countLabel.font = kFont28px;
                self.countLabel.textAlignment = NSTextAlignmentLeft;
                [self addSubview:self.countLabel];
        
        //价格
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.numberOfLines = 1;
        self.priceLabel.textColor = kColorRGB(251, 22, 78);
        self.priceLabel.font = kFont28px;
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.priceLabel];
        
        
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(94.5), kViewWidth, 0.5)];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

-(void)setModel:(IWMeOrderFormProductModel *)model{
    _model = model;
    
    //图标
    self.iconView.frame = CGRectMake(kFRate(10),kFRate(10),kFRate(80),kFRate(80));
    [self.iconView sd_setImageWithURL: [NSURL URLWithString:kImageTotalUrl(model.thumbImg)] placeholderImage:[UIImage imageNamed:model.thumbImg]];
    //名字
    self.nameLabel.text =  model.productName;
    self.nameLabel.frame = CGRectMake(kFRate(firstX),kFRate(10), contentW,  kFRate(45));
    
   
    
    CGFloat total = [model.salePrice floatValue] * [model.count floatValue];
//    self.priceLabel.text = [NSString stringWithFormat:@"￥%@  X  %@  = ￥%.2f ",model.salePrice,model.count,total];
//    model.integral
     self.priceLabel.text = [NSString stringWithFormat:@"￥%@ + %@ 贝壳 ",model.salePrice,model.integral];
    self.priceLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.nameLabel.frame) + kFRate(5), contentW - 80,  kFRate(13));
    
     // 个数
        self.countLabel.text = [NSString stringWithFormat:@"X %@",model.count];
        self.countLabel.frame = CGRectMake(kViewWidth - 50,CGRectGetMinY(self.priceLabel.frame) ,50,  kFRate(13));
    
    self.line.frame = CGRectMake(0,kFRate(99.5), kViewWidth, 0.5);
}

@end

