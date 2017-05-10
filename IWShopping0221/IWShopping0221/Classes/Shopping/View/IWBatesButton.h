//
//  IWBatesButton.h
//  IWShopping0221
//
//  Created by FRadmin on 17/2/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWBatesButton : UIButton
-(instancetype)initFrame:(CGRect)frame Icon:(NSString *)iconName selectIcon:(NSString *)selectIcon iconFrame:(CGRect)iconFrame title:(NSString *)title  titleFrame:(CGRect)titleFrame titleFont:(UIFont *)titleFont titleColor:(UIColor *)color titleSelectColor:(UIColor *)selectColor seleTitle:(NSString *)selectTitle;
@end
