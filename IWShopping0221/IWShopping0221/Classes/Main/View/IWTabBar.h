//
//  IWTabBar.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWTabBarButton.h"
@class IWTabBar;

@protocol IWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface IWTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<IWTabBarDelegate> delegate;

/**
 *  监听按钮点击
 */
- (void)buttonClick:(IWTabBarButton *)button;
@property (nonatomic, strong)NSMutableArray *tabBarButtons;
@end
