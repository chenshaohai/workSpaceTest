//
//  IWTabBarViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBarViewController.h"
#import "IWNavigationController.h"
#import "UIImage+MJ.h"
#import "IWTabBar.h"
#import "IWNearViewController.h"
#import "IWHomeViewController.h"
#import "IWShoppingVC.h"
#import "IWMeVC.h"
#import "BBLaunchAdMonitor.h"

@interface IWTabBarViewController () <IWTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) IWTabBar *customTabBar;
@property (nonatomic, strong) IWHomeViewController *home;
@property (nonatomic, strong) IWShoppingVC *shopping;
//
@property (nonatomic, strong) IWNearViewController *near;
// 4.我
@property (nonatomic, strong) IWMeVC *me;
@property (nonatomic, strong) UIViewController *category;
@end

@implementation IWTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 启动图
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *configDic = [defaults objectForKey:@"configDic"];
    NSString *path = [NSString stringWithFormat:@"%@%@",kImageUrl,configDic[@"loadImg"]];
    IWLog(@"path=======%@",path);
    [BBLaunchAdMonitor showAdAtPath:path
                             onView:self.view
                       timeInterval:2.0
                   detailParameters:@{@"carId":@(12345), @"name":@""}];
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    
}

/**
 *  定时检查未读数
 */
- (void)checkUnreadCount
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    IWTabBar *customTabBar = [[IWTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

#pragma mark - tabbar的代理方法
/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    
    if (to == 0) { // 点击了首页
//        [self.home refresh];
    }
}



/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    IWHomeViewController *home = [[IWHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"矢量智能对象" selectedImageName:@"首页e"];
    self.home = home;
    
    // 2.附近
    IWNearViewController *near = [[IWNearViewController alloc] init];
    [self setupChildViewController:near title:@"附近" imageName:@"附近" selectedImageName:@"咨询"];
    self.near = near;
    // 3.购物车
    IWShoppingVC *shopping = [[IWShoppingVC alloc] init];
    [self setupChildViewController:shopping title:@"购物车" imageName:@"购物车" selectedImageName:@"gouwuche"];
    self.shopping = shopping;
    // 4.我
    IWMeVC *me = [[IWMeVC alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"矢量智能对象副本" selectedImageName:@"我"];
    self.me = me;
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    
        childVc.tabBarItem.selectedImage = selectedImage;
    
    
    // 2.包装一个导航控制器
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}
#pragma mark - 从from切换到to 传入当前控制器
/**
 *  从from切换到to 传入当前控制器  是否是根目录
 */
-(void)from:(NSInteger )from To:(NSInteger)to isRootVC:(BOOL)isRootVC currentVC:(UIViewController *)currentVC{
    [self tabBar:nil didSelectedButtonFrom:from to:to];
    if (isRootVC == NO) {
        
        [currentVC.navigationController popToRootViewControllerAnimated:YES];
        
        
        currentVC.tabBarController.tabBar.hidden = NO;
        self.tabBar.hidden = NO;
        
        // 删除系统自动生成的UITabBarButton
        for (UIView *child in self.tabBar.subviews) {
            if ([child isKindOfClass:[UIControl class]]) {
                [child removeFromSuperview];
            }
        }
    }
    
    
    
    
    [self tabBar:nil didSelectedButtonFrom:from to:to];
    
    //改变点击
    for (IWTabBarButton *button in self.customTabBar.tabBarButtons) {
        button.selected = NO;
    }
    IWTabBarButton *button =  self.customTabBar.tabBarButtons[to];
    
    button.selected = YES;
}
@end
