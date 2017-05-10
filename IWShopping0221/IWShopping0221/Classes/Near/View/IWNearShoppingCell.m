//
//  AFTHomeCell.m

//
//  Created by 小海 on 2016/10/17.
//  Copyright © 2016年  All rights reserved.
//

#import "IWNearShoppingCell.h"
#import "TQStarRatingView.h"
@interface IWNearShoppingCell()<StarRatingViewDelegate>
@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)TQStarRatingView *starView;
//@property(nonatomic ,strong)UIImageView *selectStarView;
@property(nonatomic ,strong)UILabel *scoreLabel;
@property(nonatomic ,strong)UILabel *contentLabel;

@property(nonatomic ,strong)UILabel *countLabel;
@property(nonatomic ,strong)UILabel *distanceLabel;
@property(nonatomic ,strong)UILabel *discountLabel;
@property(nonatomic ,strong)UILabel *shoppingNameLabel;
@property(nonatomic ,strong)UIView *lineM;
@property(nonatomic ,strong)UIView *line;
@property(nonatomic ,strong)UIImageView *locationView;
@end


// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]

#define  firstX  130
#define  contentW  (kViewWidth - kFRate(firstX) - kFRate(60))

@implementation IWNearShoppingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWNearShoppingCell = @"IWNearShoppingCell";
    IWNearShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWNearShoppingCell];
    if (cell == nil) {
        cell = [[IWNearShoppingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWNearShoppingCell];
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
        self.nameLabel.numberOfLines = 1;
        self.nameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"353535"];
        self.nameLabel.font = kFont28px;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nameLabel];
        //星星
        self.starView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(kFRate(firstX),kFRate(40), kFRate(75), kFRate(13)) numberOfStar:5 large:NO];
        self.starView.contentMode = UIViewContentModeScaleAspectFill;
        self.starView.backgroundColor = kArc4randomColor;
        [self addSubview:self.starView];
        self.starView.delegate = self;
         self.starView.userInteractionEnabled = NO;
        

        
        //分数
//        self.scoreLabel = [[UILabel alloc]init];
//        self.scoreLabel.backgroundColor = [UIColor clearColor];
//        self.scoreLabel.numberOfLines = 1;
//        self.scoreLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#252837"];
//        self.scoreLabel.font = kFont18px;
//        self.scoreLabel.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.scoreLabel];
//        
//        self.scoreLabel.backgroundColor = kArc4randomColor;
        
        //评价
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.numberOfLines = 1;
        self.contentLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#252837"];
        self.contentLabel.font = kFont24px;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.contentLabel];
        
        
        UIView *lineM = [[UIView alloc]initWithFrame:CGRectMake(kFRate(firstX),kFRate(120), kViewWidth, 0.5)];
        lineM.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d8d8dd"];
        [self addSubview:lineM];
        self.lineM = lineM;
        
        
        
        UIImage *locationImage = [UIImage imageNamed:@"IWNearLocation"];
        
        UIImageView *locationView = [[UIImageView alloc]initWithImage:locationImage];
        self.locationView = locationView;
         [self addSubview:locationView];
        
        //店名
        self.shoppingNameLabel = [[UILabel alloc]init];
        self.shoppingNameLabel.backgroundColor = [UIColor clearColor];
        self.shoppingNameLabel.numberOfLines = 1;
        self.shoppingNameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#252837"];
        self.shoppingNameLabel.font = kFont24px;
        self.shoppingNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.shoppingNameLabel];
        
        
        //
//        self.countLabel = [[UILabel alloc]init];
//        self.countLabel.backgroundColor = [UIColor clearColor];
//        self.countLabel.numberOfLines = 2;
//        self.countLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#252837"];
//        self.countLabel.font = kFont18px;
//        self.countLabel.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.countLabel];
        
        //距离
        self.distanceLabel = [[UILabel alloc]init];
        self.distanceLabel.backgroundColor = [UIColor clearColor];
        self.distanceLabel.numberOfLines = 1;
        self.distanceLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#252837"];
        self.distanceLabel.font = kFont24px;
        self.distanceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.distanceLabel];
        
        
        //折扣
        self.discountLabel = [[UILabel alloc]init];
        self.discountLabel.backgroundColor = [UIColor clearColor];
        self.discountLabel.numberOfLines = 1;
        self.discountLabel.textColor = kColorRGB(232, 115, 49);
        self.discountLabel.font = kFont30px;
        self.discountLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.discountLabel];
        
       
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(120) - 0.5, kViewWidth, 0.5)];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d8d8dd"];
        [self addSubview:line];
         self.line = line;
        
    }
    return self;
}

-(void)setModel:(IWNearShoppingModel *)model{
    //图标
    self.iconView.frame = CGRectMake(kFRate(5),kFRate(10),kFRate(120),kFRate(100));
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:kImageTotalUrl(model.logo)] placeholderImage:[UIImage imageNamed:model.logo]];
    
    //名字
    self.nameLabel.text =  model.name;
    self.nameLabel.frame = CGRectMake(kFRate(firstX),kFRate(20), contentW,  kFRate(14));
    //星星
    self.starView.delegate = self;
    self.starView.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.nameLabel.frame) + kFRate(5), kFRate(75),  kFRate(13));
     [self.starView setRatingViewScore:[model.score intValue]];
 
    //评价
    self.contentLabel.text =  model.content;
    self.contentLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.starView.frame) + kFRate(7), kViewWidth - kFRate(firstX),  kFRate(14));
    
    
    self.lineM.frame =  CGRectMake(kFRate(firstX),CGRectGetMaxY(self.contentLabel.frame) + kFRate(10), kViewWidth - kFRate(firstX),  0.5);

    
    //数量
//    self.countLabel.text = [NSString stringWithFormat:@"单数%@",model.count];
//    self.countLabel.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.contentLabel.frame) + 10, 30,  kFRate(11));
   
    
    self.locationView.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.lineM.frame) + kFRate(10), kFRate(10),  kFRate(13));
    self.shoppingNameLabel.text = model.name;
    self.shoppingNameLabel.frame = CGRectMake(CGRectGetMaxX(self.locationView.frame) + 5,CGRectGetMaxY(self.lineM.frame) + kFRate(10), kViewWidth - kFRate(firstX) - kFRate(80),  kFRate(13));
#warning 隐藏 
    self.shoppingNameLabel.hidden = YES;
    
    //距离
    self.distanceLabel.text = [NSString stringWithFormat:@"附近%@ m",model.distance];
//    self.distanceLabel.frame = CGRectMake(kViewWidth - kFRate(80),CGRectGetMaxY(self.lineM.frame) + kFRate(10),kFRate(70),  kFRate(11));
    self.distanceLabel.frame = CGRectMake(CGRectGetMaxX(self.locationView.frame) + 5,CGRectGetMaxY(self.lineM.frame) + kFRate(10), kViewWidth - kFRate(firstX) - kFRate(80),  kFRate(14));
     self.line.frame = CGRectMake(0,kFRate(120) - 0.5 , kViewWidth, 0.5);
    
    //折扣
    self.discountLabel.text = [NSString stringWithFormat:@"%.1f折",[model.discount floatValue]/10];;
    self.discountLabel.frame = CGRectMake(kViewWidth - 10 - 50,CGRectGetMinY(self.starView.frame), 50, 17);
    
}
@end
