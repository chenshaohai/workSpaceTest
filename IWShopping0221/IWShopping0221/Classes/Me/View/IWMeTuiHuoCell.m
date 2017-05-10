//
//  IWMeTuiHuoCell.m
//  IWShopping0221
//
//  Created by s on 17/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeTuiHuoCell.h"

@interface IWMeTuiHuoCell()
@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UILabel *contentLabel;

@property(nonatomic ,strong)UILabel *priceLabel;
@property(nonatomic ,strong)UIButton *addBtn;
@property(nonatomic ,strong)UIButton *countBtn;
@property(nonatomic ,strong)UIButton *subBtn;

@property(nonatomic ,strong) UIView *userView;
//数量
@property(nonatomic ,strong)UILabel *countLabel;
@property(nonatomic ,strong)UIView *line;
@end


#define  firstX  130
#define  contentW  (kViewWidth - kFRate(firstX) - 15)

@implementation IWMeTuiHuoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWMeTuiHuoCell = @"IWMeTuiHuoCell";
    IWMeTuiHuoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWMeTuiHuoCell];
    if (cell == nil) {
        cell = [[IWMeTuiHuoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWMeTuiHuoCell];
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
        CGFloat buttonW = 15;
        
        
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
        
        
        CGFloat userViewW = kFRate(115);
        CGFloat userViewH = kFRate(17);
        CGFloat userButtonW = kFRate(17 + 10);
        CGFloat userViewX = kViewWidth - userViewW;
        CGFloat userViewY = kFRate(60);
        
        UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(userViewX, userViewY, userViewW, userViewH)];
        self.userView = userView;
        [self addSubview:userView];
        
        //减号
        UIButton *subBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, userButtonW, userViewH)];
        //        [subBtn setImage:selectImage  forState:UIControlStateNormal];
        [subBtn setTitle:@"-" forState:UIControlStateNormal];
        [subBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [subBtn addTarget:self action:@selector(subBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [userView addSubview:subBtn];
        self.subBtn = subBtn;
        
        
        
        //数量
        UIImage *countImage = [UIImage imageNamed:@"IWShoppingShape330"];
        UIButton *countBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(subBtn.frame) + kFRate(5), 0, userViewH, userViewH)];
        [countBtn setBackgroundImage:countImage forState:UIControlStateNormal];
        [countBtn setTitle:@"1" forState:UIControlStateNormal];
        countBtn.titleLabel.font = kFont24px;
        [countBtn setTitleColor:kColorSting(@"666666") forState:UIControlStateNormal];
        countBtn.userInteractionEnabled = NO;
        [userView addSubview:countBtn];
        self.countBtn = countBtn;
        
        //加号
        UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(countBtn.frame) + kFRate(5), 0, userButtonW, userViewH)];
        //        [addBtn setImage:selectImage  forState:UIControlStateNormal];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [userView addSubview:addBtn];
        self.addBtn = addBtn;
        
        
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(94.5), kViewWidth, 0.5)];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

-(void)addBtnClick:(UIButton *)button{
    if (self.addBtnClick) {
        self.addBtnClick(self);
    }
    
}
-(void)subBtnClick:(UIButton *)button{
    if (self.subBtnClick) {
        self.subBtnClick(self);
    }
    
}

-(void)setModel:(IWMeOrderFormProductModel *)model{
    _model = model;
    
    //图标
    self.iconView.frame = CGRectMake(kFRate(10),kFRate(10),kFRate(90),kFRate(90));
    [self.iconView sd_setImageWithURL: [NSURL URLWithString:kImageTotalUrl(model.thumbImg)] placeholderImage:nil];
    //名字
    self.nameLabel.text =  model.productName;
    self.nameLabel.frame = CGRectMake(kFRate(firstX),kFRate(5), contentW,  kFRate(30));
#warning  取不到值
    //规格
    self.contentLabel.text =  @"";
    self.contentLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.nameLabel.frame) + kFRate(7), contentW,  kFRate(13));
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %@",model.salePrice];
    self.priceLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.contentLabel.frame) + kFRate(15), contentW,  kFRate(13));
    
    [self.countBtn setTitle:model.count forState:UIControlStateNormal];
    
    self.countLabel.text = [NSString stringWithFormat:@"X %@", model.countShouHou];
    
    CGFloat userViewW = kFRate(115);
    CGFloat userViewH = kFRate(17);
    CGFloat userViewX = kViewWidth - userViewW;
    CGFloat userViewY = kFRate(70);
    
    self.userView.frame = CGRectMake(userViewX, userViewY, userViewW, userViewH);
    
    
    self.line.frame = CGRectMake(0,kFRate(109.5), kViewWidth, 0.5);
}
@end
