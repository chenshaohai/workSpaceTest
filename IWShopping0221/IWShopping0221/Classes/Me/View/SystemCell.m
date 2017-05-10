//
//  SystemCell.m
//  Supoin
//
//  Created by Arvin Wang on 14-4-23.
//  Copyright (c) 2014年 Supoin. All rights reserved.
//

#import "SystemCell.h"

@implementation SystemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        bgview.backgroundColor = [UIColor whiteColor];
        [self setBackgroundView:bgview];
        
//        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 14, 30, 30)];
//        [self.contentView addSubview:_iconImageView];
//        
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10.0, 19, 150.0, 20.0)];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 19, 100.0, 20.0)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithRed:0.3137 green:0.3137 blue:0.3137 alpha:1.0000];
        _titleLabel.font = kFont28px;
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 10.0, 19, kViewWidth - CGRectGetMaxX(_titleLabel.frame) - 55.0, 20.0)];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor colorWithRed:0.3137 green:0.3137 blue:0.3137 alpha:1.0000];
        _contentLabel.font = kFont28px;
        _contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_contentLabel];
        
        
    }
    return self;
}


@end
