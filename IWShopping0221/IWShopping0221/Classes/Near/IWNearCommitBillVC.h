//
//  IWNearCommitPayVC.h
//  IWShopping0221
//
//  Created by FRadmin on 17/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWNearCommitBillVC : UIViewController
// 店铺Id
@property (nonatomic,copy)NSString *shopId;
-(instancetype)initWithName:(NSString *)shopName andShoppingId:(NSString *)shopId;
@end
