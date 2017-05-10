//
//  IWNearShoppingDetailDiscussCell.m
//  IWShopping0221
//
//  Created by s on 17/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearShoppingDetailDiscussCell.h"
#import "TQStarRatingView.h"
@interface IWNearShoppingDetailDiscussCell()<StarRatingViewDelegate>
@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UILabel *timeLabel;
@property(nonatomic ,strong)UILabel *contentLabel;
@property(nonatomic ,strong)UIView *line;
@property(nonatomic ,strong)TQStarRatingView *starView;
@end


// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]

#define  firstX  16
#define  firstY  16

@implementation IWNearShoppingDetailDiscussCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWNearShoppingDetailDiscussCell = @"IWNearShoppingDetailDiscussCell";
    IWNearShoppingDetailDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWNearShoppingDetailDiscussCell];
    if (cell == nil) {
        cell = [[IWNearShoppingDetailDiscussCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWNearShoppingDetailDiscussCell];
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
        self.iconView.layer.cornerRadius = kFRate(15);
        self.iconView.clipsToBounds = YES;
        self.iconView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.iconView];
        //名字
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.numberOfLines = 1;
        self.nameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"666666"];
        self.nameLabel.font = kFont24px;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nameLabel];
        
        
        
        //时间
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.numberOfLines = 1;
        self.timeLabel.textColor = [UIColor HexColorToRedGreenBlue:@"c5c5c5"];
        self.timeLabel.font = kFont24px;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeLabel];
        
        
        //评价
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = [UIColor HexColorToRedGreenBlue:@"666666"];
        self.contentLabel.font = kFont28px;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.contentLabel];
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d8d8dd"];
        [self addSubview:line];
        self.line = line;
        
        
        //星星
        self.starView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(kFRate(firstX),kFRate(40), kFRate(75), kFRate(13)) numberOfStar:5 large:NO];
        self.starView.contentMode = UIViewContentModeScaleAspectFill;
        self.starView.backgroundColor = kArc4randomColor;
        [self addSubview:self.starView];
        self.starView.delegate = self;
        self.starView.userInteractionEnabled = NO;
        
        
    }
    return self;
}

-(void)setModel:(IWNearShoppingDetailDiscussModel *)model{
    _model = model;
    
    //图标
    self.iconView.frame = model.logoFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageUrl,model.logo]] placeholderImage:nil];
    
    //名字
    self.nameLabel.text =  model.name;
    self.nameLabel.frame = model.nameFrame;
    
    //时间
    self.timeLabel.frame = model.timeFrame;
    self.timeLabel.text = model.time;
    
    //评价
    self.contentLabel.text =model.content;
    self.contentLabel.frame = model.contentFrame;
    
    self.line.frame = model.lineFrame;
    
    
    
    //星星
    self.starView.delegate = self;
    self.starView.frame = model.starFrame;
    [self.starView setRatingViewScore:[model.score intValue]];
    
}
@end
