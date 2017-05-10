//
//  UIView+Frame.h
//  IWShopping0221
//
//  Created by admin on 2017/3/24.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic) CGFloat    top;
@property (nonatomic) CGFloat    bottom;
@property (nonatomic) CGFloat    left;
@property (nonatomic) CGFloat    right;

@property (nonatomic) CGFloat    x;
@property (nonatomic) CGFloat    y;
@property (nonatomic) CGPoint    origin;

@property (nonatomic) CGFloat    centerX;
@property (nonatomic) CGFloat    centerY;

@property (nonatomic) CGFloat    width;
@property (nonatomic) CGFloat    height;
@property (nonatomic) CGSize    size;
@end
