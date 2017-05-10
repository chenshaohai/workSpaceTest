//
//  IWShopBtn.m
//  IWShopping0221
//
//  Created by admin on 2017/3/16.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWShopBtn.h"

@interface IWShopBtn ()
// img
@property (nonatomic,weak)UIImageView *imgView;
// 内容
@property (nonatomic,weak)UILabel *titleLabel;
@end

@implementation IWShopBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = kFRate(0.5);
        self.layer.borderColor = IWColor(240, 240, 240).CGColor;
        // 图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height *2 / 3)];
        imgView.contentMode = UIViewContentModeCenter;
        [self addSubview:imgView];
        self.imgView = imgView;
        
        // 文字
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame), self.frame.size.width, self.frame.size.height / 3)];
        titleLabel.font = kFont24px;
        titleLabel.textColor = IWColor(95, 95, 95);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)setImg:(NSString *)img
{
    _img = img;
    self.imgView.image = _IMG(_img);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
