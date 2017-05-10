//
//  EPCardTabCell.h
//  E-Platform
//
//  Created by xsccoco on 2016/10/17.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPCardTabModel.h"


@interface EPCardTabCell : UICollectionViewCell
@property (nonatomic, strong) EPCardTabModel *model;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end
