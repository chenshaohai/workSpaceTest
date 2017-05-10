//
//  EPResearchMobileTabBar.m
//  E-Platform
//
//  Created by Apple on 2017/2/14.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "EPResearchMobileTabBar.h"

@implementation EPResearchMobileTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.collectionView.backgroundColor = COLOR_HEX(0xffffff);
        UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.5f)];
        topLineView.backgroundColor = COLOR_HEX(0xdedede);
        [self addSubview:topLineView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
