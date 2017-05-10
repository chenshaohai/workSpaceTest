//
//  IWNearSearchResultVC.h
//  IWShopping0221
//
//  Created by s on 17/2/24.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWNearSearchResultVC : UIViewController
-(instancetype)initWithCateId:(NSString *)cateId  shopName:(NSString *)shopName latitude:(CGFloat)latitude longitude:(CGFloat)longitude class:(NSString *)className;
@end
