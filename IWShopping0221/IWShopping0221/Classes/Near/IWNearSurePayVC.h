//
//  IWNearSurePayVC.h
//  IWShopping0221
//
//  Created by FRadmin on 17/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWMeVC.h"
@interface IWNearSurePayVC : UIViewController

/**
 *  订单ID 
 */
@property (nonatomic, copy)NSString *orderId;

@property (nonatomic,strong)IWMeVC *meVC;

@end
