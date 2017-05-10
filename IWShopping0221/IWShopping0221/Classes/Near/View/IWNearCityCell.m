//
//  IWNearCityCell.m
//  IWShopping0221
//
//  Created by s on 17/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearCityCell.h"

@interface IWNearCityCell()
@property(nonatomic ,strong)UILabel *nameLabel;
@end


// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]


@implementation IWNearCityCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWNearCityCell = @"IWNearCityCell";
    IWNearCityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWNearCityCell];
    if (cell == nil) {
        cell = [[IWNearCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWNearCityCell];
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
        
        
        //名字
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.numberOfLines = 1;
        self.nameLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
        self.nameLabel.font = kFont24pxBold;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nameLabel];
        
    }
    return self;
}

-(void)setCity:(NSString *)city{
    //名字
    self.nameLabel.text =  city;
    self.nameLabel.frame = CGRectMake(kFRate(10),kFRate(21), kViewWidth,  kFRate(13));
    
}
@end


