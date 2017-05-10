//
//  IWPayFilishVC.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/29.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWPayFilishVC : UIViewController
@property (nonatomic,assign)CGFloat money;
@property (nonatomic,assign)CGFloat beike;
// 订单编号
@property (nonatomic,copy)NSString *bianHao;
// 支付方式
@property (nonatomic,copy)NSString *fangShi;
// 店铺id
@property (nonatomic,copy)NSString *shopId;
// orderId
@property (nonatomic,copy)NSString *orderId;

@end
