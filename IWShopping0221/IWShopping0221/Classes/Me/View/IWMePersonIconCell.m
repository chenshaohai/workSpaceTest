//
//  IWMePersonIconCell.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/10.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMePersonIconCell.h"

@implementation IWMePersonIconCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"IWMePersonIconCell";
    IWMePersonIconCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IWMePersonIconCell" owner:nil options:nil] lastObject];
        
        //  圆形
        [cell.iconView.layer setMasksToBounds:YES];
        [cell.iconView.layer setCornerRadius:30];
    }
    return cell;
}

# pragma mark  赋值
/*
 *  赋值
 */
-(void)setUser:(IWLoginModel *)user
{
    _user = user;
    
    
    NSString *imageName = user.userImg;
    
    if (imageName && ![imageName isEqual:@""]) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:kImageTotalUrl(user.userImg)] placeholderImage:[UIImage imageNamed:@"IWTouXiang"]];
    }else{
    
    self.iconView.image = [UIImage imageNamed:@"IWTouXiang"];
    }
    self.nameLabel.text = user.userName;
    
}
@end
