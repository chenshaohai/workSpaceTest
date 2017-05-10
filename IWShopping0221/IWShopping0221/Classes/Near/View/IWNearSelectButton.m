//
//  IWNearSelectButton.m
//  IWShopping0221
//
//  Created by FRadmin on 17/2/23.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearSelectButton.h"

@implementation IWNearSelectButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:kColorSting(@"666666") forState:UIControlStateNormal];
        [self setTitleColor:IWColorRed forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = kFont28pxBold;
    }
    return  self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGRect   titleRect =   CGRectMake(0, 0, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect) -2);
    return titleRect;
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect   imageRect =   CGRectMake(0, CGRectGetMaxY(contentRect) - 2, CGRectGetWidth(contentRect), 2);
    return imageRect;
}

@end
