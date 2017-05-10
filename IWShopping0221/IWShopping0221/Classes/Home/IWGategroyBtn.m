//
//  IWGategroyBtn.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/22.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGategroyBtn.h"

@implementation IWGategroyBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *btnImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 2 / 3)];
        [self addSubview:btnImg];
        self.btnImg = btnImg;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(btnImg.frame.origin.x, CGRectGetMaxY(btnImg.frame) + kFRate(5), btnImg.frame.size.width, frame.size.height / 3)];
        title.font = kFont28px;
        title.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
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
