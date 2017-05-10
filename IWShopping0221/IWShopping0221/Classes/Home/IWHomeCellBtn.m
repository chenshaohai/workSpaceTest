//
//  IWHomeCellBtn.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/23.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeCellBtn.h"
#import "PrefixHeader.pch"

@implementation IWHomeCellBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // btn宽度
        CGFloat btnW = (kViewWidth - kFRate(20) - kFRate(30)) / 3;
        // btn测量 135 图片 110 文字 25
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btnW, btnW)];
        [self addSubview:img];
        self.img = img;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame), btnW, kFRate(40))];
        title.font = kFont24px;
        title.numberOfLines = 2;
        title.textColor = [UIColor blackColor];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        self.title = title;
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
