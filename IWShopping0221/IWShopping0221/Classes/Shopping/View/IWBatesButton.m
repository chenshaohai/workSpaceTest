//
//  IWBatesButton.m
//  IWShopping0221
//
//  Created by FRadmin on 17/2/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWBatesButton.h"

@interface IWBatesButton()


@property(nonatomic,assign)CGRect iconFrame;
@property(nonatomic,assign)CGRect titleFrame;

@end

@implementation IWBatesButton

-(instancetype)initFrame:(CGRect)frame Icon:(NSString *)iconName selectIcon:(NSString *)selectIcon iconFrame:(CGRect)iconFrame title:(NSString *)title  titleFrame:(CGRect)titleFrame titleFont:(UIFont *)titleFont titleColor:(UIColor *)color titleSelectColor:(UIColor *)selectColor seleTitle:(NSString *)selectTitle{

    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        if (selectIcon) {
            [self setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];
        }
       
        
          [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = titleFont;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:color forState:UIControlStateNormal];
        
        if (selectColor) {
            [self setTitleColor:selectColor forState:UIControlStateSelected];
        }
        if (selectTitle) {
        [self setTitle:selectTitle forState:UIControlStateSelected];
         }
        
        _iconFrame = iconFrame;
        _titleFrame = titleFrame;
    }
    return  self;

}


-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGRect   titleRect =   self.titleFrame;
    return titleRect;
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect   imageRect =   self.iconFrame;
    return imageRect;
}

@end
