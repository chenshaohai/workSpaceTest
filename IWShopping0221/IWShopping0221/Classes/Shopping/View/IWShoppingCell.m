//
//  AFTHomeCell.m

//
//  Created by 小海 on 2016/10/17.
//  Copyright © 2016年  All rights reserved.
//

#import "IWShoppingCell.h"
@interface IWShoppingCell()
@property(nonatomic ,strong)UIButton *selectBtn;
@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UILabel *contentLabel;

@property(nonatomic ,strong)UILabel *priceLabel;
@property(nonatomic ,strong)UIButton *addBtn;
@property(nonatomic ,strong)UIButton *countBtn;
@property(nonatomic ,strong)UIButton *subBtn;
@property(nonatomic ,strong)UIButton *crashBtn;

@property(nonatomic ,strong) UIView *userView;
//数量
@property(nonatomic ,strong)UILabel *countLabel;
@property(nonatomic ,strong)UIView *line;
@end


// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]

#define  firstX  130
#define  contentW  (kViewWidth - kFRate(firstX) - 15)

@implementation IWShoppingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWShoppingCell = @"IWShoppingCell";
    IWShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWShoppingCell];
    if (cell == nil) {
        cell = [[IWShoppingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWShoppingCell];
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
        UIImage *selectImage = [UIImage imageNamed:@"IWShopping椭圆2拷贝"];
        
        UIButton *selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 40, buttonW, buttonW)];
        [selectBtn setImage:selectImage  forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"IWShoppingSelect椭圆4" ] forState:UIControlStateSelected];
        selectBtn.titleLabel.font = kFont24px;
        [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectBtn];
        self.selectBtn = selectBtn;
        
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
        self.nameLabel.font = kFont24px;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nameLabel];
        
        //规格
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.numberOfLines = 1;
        self.contentLabel.textColor = [UIColor HexColorToRedGreenBlue:@"353535"];
        self.contentLabel.font = kFont22px;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.contentLabel];
        
        //价格
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.numberOfLines = 1;
        self.priceLabel.textColor = kColorRGB(251, 22, 78);
        self.priceLabel.font = kFont22px;
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.priceLabel];
        
        
        CGFloat userViewW = kFRate(115);
        CGFloat userViewH = kFRate(17);
        CGFloat userButtonW = kFRate(17 + 10);
        //        CGFloat userButtonH = kFRate(17 + 2);
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
        
        
        //删除
        UIImage *crashImage = [UIImage imageNamed:@"IWShoppingtrash"];
        UIButton *crashBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addBtn.frame) + kFRate(10), 0, userViewH, userViewH)];
        [crashBtn setImage:crashImage  forState:UIControlStateNormal];
        [crashBtn addTarget:self action:@selector(crashBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [userView addSubview:crashBtn];
        self.crashBtn = crashBtn;
        
        
        //数量
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth - userViewH * 2 - kFRate(10), kFRate(95) - kFRate(30), userViewH * 2, userViewH)];
        countLabel.font = kFont24px;
        countLabel.textColor = kColorRGB(221, 22, 78);
        [self addSubview:countLabel];
        self.countLabel = countLabel;
        countLabel.hidden = YES;
        
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(94.5), kViewWidth, 0.5)];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
        [self addSubview:line];
        self.line = line;
    }
    return self;
}
-(void)selectClick:(UIButton *)button{
    
    if (self.selectBtnClick) {
        self.selectBtnClick(self);
    }
    
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
-(void)crashBtnClick:(UIButton *)button{
    
    if (self.crashBtnClick) {
        self.crashBtnClick(self);
    }
}

-(void)setModel:(IWShoppingModel *)model{
    _model = model;
    if (model.haveSelect) {
        [self.selectBtn setImage:[UIImage imageNamed:@"IWSelect" ] forState:UIControlStateNormal];
    }else{
        [self.selectBtn setImage:[UIImage imageNamed:@"IWNoSelect"]  forState:UIControlStateNormal];
    }
    //图标
    self.iconView.frame = CGRectMake(CGRectGetMaxX(self.selectBtn.frame) + kFRate(5),kFRate(5),kFRate(85),kFRate(85));
    [self.iconView sd_setImageWithURL: [NSURL URLWithString:kImageTotalUrl(model.logo)] placeholderImage:[UIImage imageNamed:model.logo]];
    //名字
    self.nameLabel.text =  model.name;
    self.nameLabel.frame = CGRectMake(kFRate(firstX),kFRate(5), contentW,  kFRate(30));
    
    //规格
    self.contentLabel.text =  model.content;
    self.contentLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.nameLabel.frame) + kFRate(7), contentW,  kFRate(13));
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %@ + %@ 贝壳",model.price,model.integral];
    self.priceLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.contentLabel.frame) + kFRate(15), contentW,  kFRate(13));
    
    [self.countBtn setTitle:model.count forState:UIControlStateNormal];
    
    self.countLabel.text = [NSString stringWithFormat:@"X %@", model.count];
    
    
    self.line.frame = CGRectMake(0,kFRate(94.5), kViewWidth, 0.5);
}

-(void)setIsCellEdit:(BOOL)isCellEdit{
    
    _isCellEdit = isCellEdit;
    
    if (isCellEdit){
        self.userView.hidden = NO;
        self.countLabel.hidden = YES;
    }else{
        self.userView.hidden = YES;
        self.countLabel.hidden = NO;
    }
}
@end
