//
//  IWNearCommitDiscussVC.h
//  IWShopping0221
//
//  Created by FRadmin on 17/3/10.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWMeOrderFormModel.h"
#import "IWMeOrderFormVC.h"
@interface IWNearCommitDiscussVC : UIViewController
@property(nonatomic,strong)IWMeOrderFormModel *model;
@property(nonatomic,strong)IWMeOrderFormVC *orderFormVC;
@end
