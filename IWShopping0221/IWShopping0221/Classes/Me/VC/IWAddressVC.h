//
//  IWAddressVC.h
//  IWShopping0221
//
//  Created by admin on 2017/3/8.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWAddressVC : UIViewController
@property (nonatomic, copy) void(^refreshBlock)(IWAddressVC *addressVC);
@end
