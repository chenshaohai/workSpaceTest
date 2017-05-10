//
//  IWTabBarViewController.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWTabBar.h"

@interface IWTabBarViewController : UITabBarController

#pragma mark - 从from切换到to 传入当前控制器
/**
 *  从from切换到to 传入当前控制器  是否是根目录
 */
-(void)from:(NSInteger )from To:(NSInteger)to isRootVC:(BOOL)isRootVC currentVC:(UIViewController *)currentVC;
@end
