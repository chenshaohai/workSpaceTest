//
//  IWModifyVC.h
//  IWShopping0221
//
//  Created by s on 17/3/12.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWModifyVC : UIViewController


@property(nonatomic,copy) void (^sureButtonClick)(IWModifyVC *modify,NSString *modifyText);

-(instancetype)initWithTitle:(NSString *)titleName contentString:(NSString *)contentString showString:(NSString *)showString;

@end
