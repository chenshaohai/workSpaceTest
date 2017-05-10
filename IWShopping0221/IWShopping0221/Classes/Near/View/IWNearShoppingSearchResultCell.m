//
//  IWNearShoppingSearchResultCell.m
//  IWShopping0221
//
//  Created by s on 17/2/24.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearShoppingSearchResultCell.h"
#import "TQStarRatingView.h"
@interface IWNearShoppingSearchResultCell()<StarRatingViewDelegate>
@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)TQStarRatingView *starView;
//@property(nonatomic ,strong)UIImageView *selectStarView;
//@property(nonatomic ,strong)UILabel *scoreLabel;
@property(nonatomic ,strong)UILabel *contentLabel;

//@property(nonatomic ,strong)UILabel *countLabel;
//@property(nonatomic ,strong)UILabel *distanceLabel;
@property(nonatomic ,strong)UILabel *discountLabel;
@property(nonatomic ,strong)UIView *line;
@end


// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]

#define  firstX  130
#define  contentW  (kViewWidth - kFRate(firstX))

@implementation IWNearShoppingSearchResultCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWNearShoppingSearchResultCell = @"IWNearShoppingSearchResultCell";
    IWNearShoppingSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWNearShoppingSearchResultCell];
    if (cell == nil) {
        cell = [[IWNearShoppingSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWNearShoppingSearchResultCell];
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
        self.nameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
        self.nameLabel.font = kFont24pxBold;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nameLabel];
        //星星
        self.starView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(firstX, 40, kFRate(75), kFRate(13)) numberOfStar:5 large:NO];
        self.starView.contentMode = UIViewContentModeScaleAspectFill;
        self.starView.backgroundColor = kArc4randomColor;
        [self addSubview:self.starView];
        self.starView.delegate = self;
        self.starView.userInteractionEnabled = NO;
        
        
        
        //折扣
        self.discountLabel = [[UILabel alloc]init];
        self.discountLabel.backgroundColor = [UIColor clearColor];
        self.discountLabel.numberOfLines = 1;
        self.discountLabel.textColor = kColorRGB(232, 115, 49);
        self.discountLabel.font = kFont30px;
        self.discountLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.discountLabel];
       
     
        //评价
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
        self.contentLabel.font = kFont22px;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.contentLabel];
        
       
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(120), kViewWidth, 0.5)];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d8d8dd"];
        [self addSubview:line];
        self.line = line;
        
        
    }
    return self;
}

-(void)setModel:(IWNearShoppingModel *)model{
    //图标
    self.iconView.frame = CGRectMake(kFRate(5),kFRate(10),kFRate(114.5),kFRate(98.5));
    
     [self.iconView sd_setImageWithURL:[NSURL URLWithString:kImageTotalUrl(model.logo)] placeholderImage:[UIImage imageNamed:model.logo]];
    
    //    CGFloat  firstX = 130;
    //    CGFloat  contentW = kViewWidth - kFRate(firstX) - 60;
    //名字
    self.nameLabel.text =  model.name;
    self.nameLabel.frame = CGRectMake(kFRate(firstX),kFRate(21), contentW,  kFRate(13));
    //星星
    self.starView.delegate = self;
    [self.starView setRatingViewScore:[model.score intValue]];
    self.starView.frame = CGRectMake(kFRate(firstX),CGRectGetMaxY(self.nameLabel.frame) + 5,kFRate(75), kFRate(13));
    
    
    //折扣
    self.discountLabel.text = [NSString stringWithFormat:@"%.1f折",[model.discount floatValue]/10];;
    self.discountLabel.frame = CGRectMake(kViewWidth - 10 - 50,CGRectGetMinY(self.starView.frame), 50, 17);
    
    
    //评价
    self.contentLabel.text =  model.content;
    CGFloat contentY = CGRectGetMaxY(self.starView.frame) + 8.5;
    self.contentLabel.frame = CGRectMake(kFRate(firstX),contentY, contentW, kFRate(120) - contentY - kFRate(21));
    
    self.line.frame = CGRectMake(0,kFRate(120)-0.5, kViewWidth, 0.5);
    
//    self.contentLabel.backgroundColor = [UIColor lightGrayColor];
    
}
@end

