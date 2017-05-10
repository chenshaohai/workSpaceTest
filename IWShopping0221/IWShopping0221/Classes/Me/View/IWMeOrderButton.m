//
//  IWMeOrderButton.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/16.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeOrderButton.h"

@implementation IWMeOrderButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //设置边框及颜色 默认给个颜色 红色边框
        [self.layer setBorderColor:[UIColor redColor].CGColor];
        [self.layer setBorderWidth:1.0];
        [self.layer setCornerRadius:2.0];
        [self.layer setMasksToBounds: YES];
    }
    
    
    return self;
    
}

-(void)setPadColor:(UIColor *)padColor{
    _padColor = padColor;
    //设置边框及颜色
    [self.layer setBorderColor:padColor.CGColor];
    [self.layer setBorderWidth:1.0];
    [self.layer setCornerRadius:2.0];
    [self.layer setMasksToBounds: YES];
    
}
@end
