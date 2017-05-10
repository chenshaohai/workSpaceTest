//
//  IWHomeCellBtn.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/23.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWHomeCellBtn : UIButton
// 按钮indexPath属性
@property (nonatomic,strong)NSIndexPath *indexPath;
// 图片
@property (nonatomic,weak)UIImageView *img;
// 文字
@property (nonatomic,weak)UILabel *title;
@end
