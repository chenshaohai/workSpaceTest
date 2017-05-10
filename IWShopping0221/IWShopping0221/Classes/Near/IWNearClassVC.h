//
//  IWNearClassVC.h
//  IWShopping0221
//
//  Created by s on 17/3/2.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWNearClassVC,IWNearTopModel;

typedef void(^IWNearClassVCClassClick) (IWNearClassVC *classVC,IWNearTopModel *model);

@interface IWNearClassVC : UIViewController

/**
 *  Cell点击的block
 */
@property (nonatomic,copy)IWNearClassVCClassClick cellClick;
-(instancetype)initWithCateArray:(NSArray *)data;
@end
