//
//  IWMeOrderButton.h
//  IWShopping0221
//
//  Created by FRadmin on 17/3/16.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWMeShouHouModel.h"
#import "IWMeOrderFormModel.h"
@interface IWMeOrderButton : UIButton
// 图片
@property (nonatomic,strong)IWMeOrderFormModel *OrderFormModel;
// name
@property (nonatomic,assign)NSInteger section;

// 外圈颜色
@property (nonatomic,strong)UIColor *padColor;

@property (nonatomic,strong)IWMeShouHouModel *model;
@end
