//
//  IWMeShouHouCell.m
//  IWShopping0221
//
//  Created by s on 17/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeShouHouCell.h"
@interface IWMeShouHouCell()
@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UILabel *contentLabel;

@property(nonatomic ,strong)UILabel *priceLabel;
@property(nonatomic ,strong)UILabel *countLabel;
//类型
@property(nonatomic ,strong)UILabel *classLabel;
@property(nonatomic ,strong)UIView *line;
@end


// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]

#define  firstX  100
#define  contentW  (kViewWidth - kFRate(firstX) - 15)

@implementation IWMeShouHouCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWMeShouHouCell = @"IWMeShouHouCell";
    IWMeShouHouCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWMeShouHouCell];
    if (cell == nil) {
        cell = [[IWMeShouHouCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWMeShouHouCell];
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
        
//        规格
//                self.contentLabel = [[UILabel alloc]init];
//                self.contentLabel.backgroundColor = [UIColor clearColor];
//                self.contentLabel.numberOfLines = 1;
//                self.contentLabel.textColor = [UIColor lightGrayColor];
//                self.contentLabel.font = kFont28px;
//                self.contentLabel.textAlignment = NSTextAlignmentLeft;
//                [self addSubview:self.contentLabel];
        
        //价格
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.numberOfLines = 1;
        self.priceLabel.textColor = IWColorRed;
        self.priceLabel.font = kFont28px;
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.priceLabel];
        
        //数量
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.backgroundColor = [UIColor clearColor];
        self.countLabel.numberOfLines = 1;
        self.countLabel.textColor = [UIColor lightGrayColor];
        self.countLabel.font = kFont28px;
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.countLabel];
        
        //类型
        self.classLabel = [[UILabel alloc]init];
        self.classLabel.backgroundColor = [UIColor clearColor];
        self.classLabel.numberOfLines = 1;
        self.classLabel.textColor = IWColorRed;
        self.classLabel.font = kFont28px;
        self.classLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.classLabel];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(117.5), kViewWidth, 0.5)];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

-(void)setModel:(IWMeShouHouModel *)model{
    _model = model;
    
    //图标
    self.iconView.frame = CGRectMake(kFRate(10),(kFRate(118) - kFRate(85))/2.0 ,kFRate(85),kFRate(85));
    [self.iconView sd_setImageWithURL: [NSURL URLWithString:kImageTotalUrl(model.thumbImg)] placeholderImage:[UIImage imageNamed:model.thumbImg]];
    //名字
    self.nameLabel.text =  model.productName;
    self.nameLabel.frame = CGRectMake(kFRate(firstX),kFRate(20), contentW,  kFRate(35));
    
    //规格
//        self.contentLabel.text =  model.productName;
//        self.contentLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.nameLabel.frame) + kFRate(7), contentW,  kFRate(13));
    
    self.countLabel.text = [NSString stringWithFormat:@"X%@",model.refundCount];
    self.countLabel.frame = CGRectMake(kViewWidth - kFRate(70),CGRectGetMinY(self.nameLabel.frame), kFRate(60),  kFRate(35));
    
    
    self.priceLabel.text = [NSString stringWithFormat:@"退款金额:￥%@",model.refundMoney];
    self.priceLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.nameLabel.frame) + kFRate(15), contentW - kFRate(100),  kFRate(13));
    

//    state退换状态，0表示待审核，1表示退换中，2表示退换完成，-1表示退换取消
//    欧阳  20:46:05
//    refundType退换类型（1表示只退款，2表示只退货，3表示退款并退货，4表示换货）
    
    
    NSString *refundString = @"只退款";
    if ([model.refundType isEqual:@"2"]) {
        refundString = @"只退货";
    }else if ([model.refundType isEqual:@"3"]) {
        refundString = @"表示退款并退货";
    }else if ([model.refundType isEqual:@"4"]) {
        refundString = @"换货";
    }
    
    
    //类型
    self.classLabel.text = refundString;
    self.classLabel.frame = CGRectMake(kViewWidth - kFRate(80) - kFRate(10) ,CGRectGetMinY(self.priceLabel.frame), kFRate(70),  kFRate(13));
    
    
    
    self.line.frame = CGRectMake(0,kFRate(117.5), kViewWidth, 0.5);
}

@end

