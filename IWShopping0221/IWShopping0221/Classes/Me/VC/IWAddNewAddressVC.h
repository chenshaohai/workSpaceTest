//
//  IWAddNewAddressVC.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/10.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWAddressModel.h"

@interface IWAddNewAddressVC : UIViewController
// 编辑所传模型
@property (nonatomic,strong)IWAddressModel *model;
// 判断是否为新增
@property (nonatomic,assign)BOOL isAdd;
// 判断是否为新增
@property (nonatomic,copy)void (^saveSuccess)(IWAddNewAddressVC *VC,IWAddressModel *model);
@end
