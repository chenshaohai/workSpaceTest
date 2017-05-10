//
//  IWMeOrderFormVC.h
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWMeVC.h"
@interface IWMeOrderFormVC : UIViewController
//回跳的根 tabbar
@property (nonatomic,assign)NSInteger needPOPToRootIndex;
@property (nonatomic,strong)IWMeVC *meVC;

@property(nonatomic,assign)BOOL needNoRefresh;


-(instancetype)initWithSelectIndex:(NSInteger )index;
@end
