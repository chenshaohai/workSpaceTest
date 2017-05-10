//
//  PPMTopButton.m
//  PPM
//
//  Created by lu_ios on 17/4/14.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import "PPMTopButton.h"

@implementation PPMTopButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
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
