//
//  EPCardTabCell.m
//  E-Platform
//
//  Created by xsccoco on 2016/10/17.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import "EPCardTabCell.h"
#import "UIView+Frame.h"

@interface EPCardTabCell ()

@end

@implementation EPCardTabCell

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.bottom, self.width, 16)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = MyFont(10);
        _nameLabel.textColor = COLOR_RGB(200, 200, 200);
         [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - 24) / 2, 5, 24, 24)];
         [self addSubview:_imageView];
    }
    return _imageView;
}


- (void)setModel:(EPCardTabModel *)model {
    if (model) {
        _model = model;
        self.imageView.image = [UIImage imageNamed:model.imgUrl];
        self.nameLabel.text = model.tabTitle;
        if (model.isSelect) {
            self.imageView.image = [UIImage imageNamed:model.selectImgUrl];
            self.nameLabel.textColor = COLOR_RGB(72, 213, 205);
        }else
        {
            self.imageView.image = [UIImage imageNamed:model.imgUrl];
            self.nameLabel.textColor = COLOR_RGB(153, 153, 153);
        }
    }
}


@end
